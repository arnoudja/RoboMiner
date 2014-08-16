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
import java.util.Map;
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
import nl.robominer.session.MiningQueueFacade;
import nl.robominer.session.ProgramSourceFacade;
import nl.robominer.session.RobotFacade;
import nl.robominer.session.RobotPartFacade;
import nl.robominer.session.UserRobotPartAssetFacade;

/**
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "RobotServlet", urlPatterns = {"/robot"})
public class RobotServlet extends RoboMinerServletBase {

    @Resource
    UserTransaction transaction;
    
    @EJB
    private RobotFacade robotFacade;
    
    @EJB
    private ProgramSourceFacade programSourceFacade;
    
    @EJB
    private RobotPartFacade robotPartFacade;
    
    @EJB
    private UserRobotPartAssetFacade userRobotPartAssetFacade;
    
    @EJB
    private MiningQueueFacade miningQueueFacade;
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int userId = (int) request.getSession().getAttribute("userId");
        
        int robotId = getItemId(request, "robotId");
        
        if (robotId > 0) {
            updateRobot(request, robotId, userId);
            request.setAttribute("robotId", robotId);
        }
        
        // Add the list of robots
        List<Robot> robotList = robotFacade.findByUsersId(userId);
        request.setAttribute("robotList", robotList);
        
        // Add the list of program sources
        Map<Integer, ProgramSource> programSourceMap = programSourceFacade.findMapByUsersId(userId);
        request.setAttribute("programSourceMap", programSourceMap);

        // Add the list of ore containers
        List<UserRobotPartAsset> oreContainerList = userRobotPartAssetFacade.findByUsersIdAndPartType(userId, 1);
        request.setAttribute("oreContainerList", oreContainerList);
        
        // Add the list of mining units
        List<UserRobotPartAsset> miningUnitList = userRobotPartAssetFacade.findByUsersIdAndPartType(userId, 2);
        request.setAttribute("miningUnitList", miningUnitList);
        
        // Add the list of batteries
        List<UserRobotPartAsset> batteryList = userRobotPartAssetFacade.findByUsersIdAndPartType(userId, 3);
        request.setAttribute("batteryList", batteryList);
        
        // Add the list of memory modules
        List<UserRobotPartAsset> memoryModuleList = userRobotPartAssetFacade.findByUsersIdAndPartType(userId, 4);
        request.setAttribute("memoryModuleList", memoryModuleList);
        
        // Add the list of CPU's
        List<UserRobotPartAsset> cpuList = userRobotPartAssetFacade.findByUsersIdAndPartType(userId, 5);
        request.setAttribute("cpuList", cpuList);
        
        // Add the list of engines
        List<UserRobotPartAsset> engineList = userRobotPartAssetFacade.findByUsersIdAndPartType(userId, 6);
        request.setAttribute("engineList", engineList);
        
        // Add the map of memory modules
        Map<Integer, RobotPart> memoryModuleMap = robotPartFacade.findTypeMapped(4);
        request.setAttribute("memoryModuleMap", memoryModuleMap);
        
        request.getRequestDispatcher("/WEB-INF/view/robot.jsp").forward(request, response);
    }

    private void updateRobot(HttpServletRequest request, int robotId, int usersId) {
        
        String robotName = request.getParameter("robotName" + robotId);
        
        int programSourceId = getItemId(request, "programSourceId" + robotId);
        int oreContainerId  = getItemId(request, "oreContainerId" + robotId);
        int miningUnitId    = getItemId(request, "miningUnitId" + robotId);
        int batteryId       = getItemId(request, "batteryId" + robotId);
        int memoryModuleId  = getItemId(request, "memoryModuleId" + robotId);
        int cpuId           = getItemId(request, "cpuId" + robotId);
        int engineId        = getItemId(request, "engineId" + robotId);
        
        ProgramSource programSource = programSourceFacade.findByIdAndUser(programSourceId, usersId);
        
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

                Robot robot = robotFacade.findByIdAndUser(robotId, usersId);

                if (robot != null) {

                    if (!miningQueue.isEmpty()) {
                        request.setAttribute("errorMessage", "Unable to apply, robot " + robot.getRobotName() + " is busy");
                    }
                    else {

                        robot.setRobotName(robotName);
                        robot.setProgramSourceId(programSourceId);
                        robot.setSourceCode(programSource.getSourceCode());

                        if (robot.getOreContainer().getId() != oreContainerId) {
                            
                            swapUnitStock(usersId, robot.getOreContainer().getId(), oreContainerId);
                            robot.setOreContainer(oreContainer);
                        }
                        
                        if (robot.getMiningUnit().getId() != miningUnitId) {
                            
                            swapUnitStock(usersId, robot.getMiningUnit().getId(), miningUnitId);
                            robot.setMiningUnit(miningUnit);
                        }
                        
                        if (robot.getBattery().getId() != batteryId) {
                            
                            swapUnitStock(usersId, robot.getBattery().getId(), batteryId);
                            robot.setBattery(battery);
                        }
                        
                        if (robot.getMemoryModule().getId() != memoryModuleId) {
                            
                            swapUnitStock(usersId, robot.getMemoryModule().getId(), memoryModuleId);
                            robot.setMemoryModule(memoryModule);
                        }
                        
                        if (robot.getCpu().getId() != cpuId) {
                            
                            swapUnitStock(usersId, robot.getCpu().getId(), cpuId);
                            robot.setCpu(cpu);
                        }
                        
                        if (robot.getEngine().getId() != engineId) {
                            
                            swapUnitStock(usersId, robot.getEngine().getId(), engineId);
                            robot.setEngine(engine);
                        }
                        
                        robot.updateParameters();

                        robotFacade.edit(robot);
                    }
                }
                
                transaction.commit();
            }
            catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException exc) {
                
                try {
                    transaction.rollback();
                }
                catch (IllegalStateException | SecurityException | SystemException exc2) {
                }
            }
        }
    }

    private void swapUnitStock(int usersId, int oldPartId, int newPartId) {
        
        UserRobotPartAsset newContainerAsset = userRobotPartAssetFacade.findByUsersIdAndRobotPartId(usersId, newPartId);
        UserRobotPartAsset oldContainerAsset = userRobotPartAssetFacade.findByUsersIdAndRobotPartId(usersId, oldPartId);

        if (newContainerAsset == null || newContainerAsset.getAmount() <= 0) {
            throw new IllegalStateException();
        }

        newContainerAsset.removeOne();
        userRobotPartAssetFacade.edit(newContainerAsset);

        if (oldContainerAsset == null) {

            oldContainerAsset = new UserRobotPartAsset(usersId, oldPartId, 1);
            userRobotPartAssetFacade.create(oldContainerAsset);
        }
        else {

            oldContainerAsset.addOne();
            userRobotPartAssetFacade.edit(oldContainerAsset);
        }
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
