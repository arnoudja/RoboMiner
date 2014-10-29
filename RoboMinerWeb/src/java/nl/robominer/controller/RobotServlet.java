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
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nl.robominer.entity.MiningQueue;
import nl.robominer.entity.ProgramSource;
import nl.robominer.entity.Robot;
import nl.robominer.entity.RobotPart;
import nl.robominer.entity.UserRobotPartAsset;
import nl.robominer.entity.Users;
import nl.robominer.session.MiningQueueFacade;
import nl.robominer.session.RobotPartFacade;
import nl.robominer.session.UsersFacade;

/**
 * Servlet for handling robot modification requests.
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "RobotServlet", urlPatterns = {"/robot"})
public class RobotServlet extends RoboMinerServletBase
{
    /**
     * The javascript view used for displaying the program source page.
     */
    private static final String JAVASCRIPT_VIEW = "/WEB-INF/view/robot.jsp";

    /**
     * The session attribute id for storing the selected robot.
     */
    private final static String SESSION_ROBOT_ID = "robot_robotId";

    /**
     * Bean to handle the database actions for the user information.
     */
    @EJB
    private UsersFacade usersFacade;

    /**
     * Bean to handle the database actions for the robot part information.
     */
    @EJB
    private RobotPartFacade robotPartFacade;

    /**
     * Bean to handle the database actions for the mining queue information.
     */
    @EJB
    private MiningQueueFacade miningQueueFacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  The servlet request.
     * @param response The servlet response.
     *
     * @throws ServletException if a servlet-specific error occurs.
     * @throws IOException      if an I/O error occurs.
     */
    @Override
    protected void processRequest(HttpServletRequest request,
                                  HttpServletResponse response)
            throws ServletException, IOException
    {
        Users user = usersFacade.findById(getUserId(request));

        int robotId = getItemId(request, "robotId");

        Robot robot = user.getRobot(robotId);

        if (robot != null)
        {
            try
            {
                updateRobot(request, robot);
                usersFacade.edit(user);
            }
            catch (IllegalStateException | IllegalArgumentException exc)
            {
                throw new ServletException(exc);
            }
  
            request.getSession().setAttribute(SESSION_ROBOT_ID, robotId);
        }
        else if (request.getSession().getAttribute(SESSION_ROBOT_ID) != null)
        {
            robotId = (int)request.getSession().getAttribute(SESSION_ROBOT_ID);
        }

        // Add the selected robot id to the request.
        if (robotId > 0)
        {
            request.setAttribute("robotId", robotId);
        }

        // Add the user account information to the request.
        request.setAttribute("user", user);

        // Forward the information to the jsp view layer.
        request.getRequestDispatcher(JAVASCRIPT_VIEW).forward(request, response);
    }

    /**
     * Update the robot configuration as requested.
     *
     * @param request The servlet request containing the configuration changes.
     * @param robot   The robot to change the configuration for.
     *
     * @throws IllegalStateException if the user assets don't allow the new configuration.
     * @throws IllegalArgumentException if the new robot name isn't allowed.
     */
    private void updateRobot(HttpServletRequest request, Robot robot)
            throws IllegalStateException, IllegalArgumentException
    {
        String robotName    = request.getParameter("robotName" + robot.getId());

        int programSourceId = getItemId(request, "programSourceId" + robot.getId());
        int oreContainerId  = getItemId(request, "oreContainerId" + robot.getId());
        int miningUnitId    = getItemId(request, "miningUnitId" + robot.getId());
        int batteryId       = getItemId(request, "batteryId" + robot.getId());
        int memoryModuleId  = getItemId(request, "memoryModuleId" + robot.getId());
        int cpuId           = getItemId(request, "cpuId" + robot.getId());
        int engineId        = getItemId(request, "engineId" + robot.getId());

        ProgramSource programSource = robot.getUser().getProgramSource(programSourceId);

        RobotPart oreContainer = robotPartFacade.find(oreContainerId);
        RobotPart miningUnit   = robotPartFacade.find(miningUnitId);
        RobotPart battery      = robotPartFacade.find(batteryId);
        RobotPart memoryModule = robotPartFacade.find(memoryModuleId);
        RobotPart cpu          = robotPartFacade.find(cpuId);
        RobotPart engine       = robotPartFacade.find(engineId);

        if (!robot.getChangePending() &&
            robotName != null && programSource != null &&
            oreContainer != null && miningUnit != null && battery != null &&
            memoryModule != null && cpu != null && engine != null &&
            memoryModule.getMemoryCapacity() >= programSource.getCompiledSize())
        {
            List<MiningQueue> miningQueue = miningQueueFacade.findWaitingByRobotId(robot.getId());

            boolean pending = (!miningQueue.isEmpty() && !robot.isRecharging());

            if (pending)
            {
                robot.makeChangesPending();
            }

            robot.setRobotName(robotName);
            robot.setProgramSourceId(programSourceId);

            if (programSource.getVerified())
            {
                robot.setSourceCode(programSource.getSourceCode());
            }

            if (robot.getOreContainer().getId() != oreContainerId &&
                robot.getUser().getUnassignedRobotPartAmount(oreContainer) <= 0)
            {
                throw new IllegalStateException();
            }
            robot.setOreContainer(oreContainer);

            if (robot.getMiningUnit().getId() != miningUnitId &&
                robot.getUser().getUnassignedRobotPartAmount(miningUnit) <= 0)
            {
                throw new IllegalStateException();
            }
            robot.setMiningUnit(miningUnit);

            if (robot.getBattery().getId() != batteryId &&
                robot.getUser().getUnassignedRobotPartAmount(battery) <= 0)
            {
                throw new IllegalStateException();
            }
            robot.setBattery(battery);

            if (robot.getMemoryModule().getId() != memoryModuleId &&
                robot.getUser().getUnassignedRobotPartAmount(memoryModule) <= 0)
            {
                throw new IllegalStateException();
            }
            robot.setMemoryModule(memoryModule);

            if (robot.getCpu().getId() != cpuId &&
                robot.getUser().getUnassignedRobotPartAmount(cpu) <= 0)
            {
                throw new IllegalStateException();
            }
            robot.setCpu(cpu);

            if (robot.getEngine().getId() != engineId &&
                robot.getUser().getUnassignedRobotPartAmount(engine) <= 0)
            {
                throw new IllegalStateException();
            }
            robot.setEngine(engine);

            robot.updateParameters();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description.
     */
    @Override
    public String getServletInfo()
    {
        return "Robot configuration controller servlet";
    }
}
