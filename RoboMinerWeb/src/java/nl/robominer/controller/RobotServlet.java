/*
 * Copyright (C) 2014 Arnoud Jagerman
 *
 * This file is part of RoboMiner.
 *
 * RoboMiner is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * RoboMiner is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package nl.robominer.controller;

import java.io.IOException;
import java.util.List;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.HeuristicMixedException;
import javax.transaction.HeuristicRollbackException;
import javax.transaction.NotSupportedException;
import javax.transaction.RollbackException;
import javax.transaction.SystemException;
import javax.transaction.UserTransaction;
import nl.robominer.entity.MiningQueue;
import nl.robominer.entity.ProgramSource;
import nl.robominer.entity.Robot;
import nl.robominer.entity.RobotPart;
import nl.robominer.entity.UserRobotPartAsset;
import nl.robominer.entity.Users;
import nl.robominer.session.MiningQueueFacade;
import nl.robominer.session.RobotFacade;
import nl.robominer.session.RobotPartFacade;
import nl.robominer.session.UserRobotPartAssetFacade;
import nl.robominer.session.UsersFacade;

/**
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "RobotServlet", urlPatterns = {"/robot"})
public class RobotServlet extends RoboMinerServletBase {

    private final static String SESSION_ROBOT_ID = "robot_robotId";

    @Resource
    UserTransaction transaction;
    
    @EJB
    private RobotFacade robotFacade;
    
    @EJB
    private RobotPartFacade robotPartFacade;
    
    @EJB
    private UserRobotPartAssetFacade userRobotPartAssetFacade;
    
    @EJB
    private MiningQueueFacade miningQueueFacade;

    @EJB
    private UsersFacade usersFacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request The servlet request.
     * @param response The servlet response.
     * @throws ServletException if a servlet-specific error occurs.
     * @throws IOException if an I/O error occurs.
     */
    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Users user = usersFacade.findById(getUserId(request));

        int robotId = getItemId(request, "robotId");

        if (robotId > 0) {

            updateRobot(request, robotId, user);
            request.getSession().setAttribute(SESSION_ROBOT_ID, robotId);
        }
        else if (request.getSession().getAttribute(SESSION_ROBOT_ID) != null) {
            robotId = (int)request.getSession().getAttribute(SESSION_ROBOT_ID);
        }

        // Add the selected robot
        if (robotId > 0) {
            request.setAttribute("robotId", robotId);
        }

        // Add the user account information to the request.
        request.setAttribute("user", user);

        request.getRequestDispatcher("/WEB-INF/view/robot.jsp").forward(request, response);
    }

    private void updateRobot(HttpServletRequest request, int robotId, Users user) throws ServletException {

        String robotName = request.getParameter("robotName" + robotId);

        int programSourceId = getItemId(request, "programSourceId" + robotId);
        int oreContainerId  = getItemId(request, "oreContainerId" + robotId);
        int miningUnitId    = getItemId(request, "miningUnitId" + robotId);
        int batteryId       = getItemId(request, "batteryId" + robotId);
        int memoryModuleId  = getItemId(request, "memoryModuleId" + robotId);
        int cpuId           = getItemId(request, "cpuId" + robotId);
        int engineId        = getItemId(request, "engineId" + robotId);

        ProgramSource programSource = user.getProgramSource(programSourceId);

        RobotPart oreContainer = robotPartFacade.find(oreContainerId);
        RobotPart miningUnit   = robotPartFacade.find(miningUnitId);
        RobotPart battery      = robotPartFacade.find(batteryId);
        RobotPart memoryModule = robotPartFacade.find(memoryModuleId);
        RobotPart cpu          = robotPartFacade.find(cpuId);
        RobotPart engine       = robotPartFacade.find(engineId);

        if (robotName != null && robotName.matches("[A-Za-z0-9_]{1,10}") && programSource != null &&
            oreContainer != null && miningUnit != null && battery != null &&
            memoryModule != null && cpu != null && engine != null &&
            memoryModule.getMemoryCapacity() >= programSource.getCompiledSize()) {

            List<MiningQueue> miningQueue = miningQueueFacade.findWaitingByRobotId(robotId);

            try {

                transaction.begin();

                Robot robot = user.getRobot(robotId);

                if (robot != null) {

                    if (!miningQueue.isEmpty()) {
                        request.setAttribute("errorMessage", "Unable to apply, robot " + robot.getRobotName() + " is busy");
                    }
                    else {

                        robot.setRobotName(robotName);
                        robot.setProgramSourceId(programSourceId);
                        robot.setSourceCode(programSource.getSourceCode());

                        if (robot.getOreContainer().getId() != oreContainerId) {

                            swapUnitStock(user.getId(), robot.getOreContainer().getId(), oreContainerId);
                            robot.setOreContainer(oreContainer);
                        }

                        if (robot.getMiningUnit().getId() != miningUnitId) {

                            swapUnitStock(user.getId(), robot.getMiningUnit().getId(), miningUnitId);
                            robot.setMiningUnit(miningUnit);
                        }

                        if (robot.getBattery().getId() != batteryId) {

                            swapUnitStock(user.getId(), robot.getBattery().getId(), batteryId);
                            robot.setBattery(battery);
                        }

                        if (robot.getMemoryModule().getId() != memoryModuleId) {

                            swapUnitStock(user.getId(), robot.getMemoryModule().getId(), memoryModuleId);
                            robot.setMemoryModule(memoryModule);
                        }

                        if (robot.getCpu().getId() != cpuId) {

                            swapUnitStock(user.getId(), robot.getCpu().getId(), cpuId);
                            robot.setCpu(cpu);
                        }

                        if (robot.getEngine().getId() != engineId) {

                            swapUnitStock(user.getId(), robot.getEngine().getId(), engineId);
                            robot.setEngine(engine);
                        }

                        robot.updateParameters();

                        robotFacade.edit(robot);
                    }
                }

                transaction.commit();
            }
            catch (NotSupportedException | SystemException | RollbackException |
                   HeuristicMixedException | HeuristicRollbackException |
                   SecurityException | IllegalStateException exc) {

                try {
                    transaction.rollback();
                    throw new ServletException(exc);
                }
                catch (IllegalStateException | SecurityException | SystemException exc2) {
                    throw new ServletException(exc2);
                }
            }
        }
    }

    private void swapUnitStock(int usersId, int oldPartId, int newPartId) {
        
        UserRobotPartAsset newContainerAsset = userRobotPartAssetFacade.findByUsersIdAndRobotPartId(usersId, newPartId);
        UserRobotPartAsset oldContainerAsset = userRobotPartAssetFacade.findByUsersIdAndRobotPartId(usersId, oldPartId);

        if (newContainerAsset == null || newContainerAsset.getUnassigned() <= 0 ||
            oldContainerAsset == null) {
            throw new IllegalStateException();
        }

        newContainerAsset.assignOne();
        oldContainerAsset.unassignOne();

        userRobotPartAssetFacade.edit(newContainerAsset);
        userRobotPartAssetFacade.edit(oldContainerAsset);
    }
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Robot configuration controller servlet";
    }

}
