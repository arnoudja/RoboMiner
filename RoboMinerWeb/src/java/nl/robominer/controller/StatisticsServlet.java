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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nl.robominer.businessentity.RobotStatistics;
import nl.robominer.entity.MiningOreResult;
import nl.robominer.entity.MiningQueue;
import nl.robominer.entity.Robot;
import nl.robominer.session.MiningQueueFacade;
import nl.robominer.session.RobotFacade;

/**
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "StatisticsServlet", urlPatterns = {"/statistics"})
public class StatisticsServlet extends RoboMinerServletBase {

    private static final int LAST_RESULT_COUNT = 100;

    @EJB
    private RobotFacade robotFacade;

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

        processAssets(request);

        // Add the list of robots
        List<Robot> robotList = robotFacade.findByUsersId(userId);
        request.setAttribute("robotList", robotList);

        // Calculate the last results totals
        Map<Integer, RobotStatistics> robotStatisticsMap = new HashMap<>();

        for (Robot robot : robotList) {

            List<MiningQueue> robotResults = miningQueueFacade.findResultsByRobotId(robot.getId(), LAST_RESULT_COUNT);

            RobotStatistics robotStatistics = new RobotStatistics();

            robotStatistics.setRuns(robotResults.size());

            for (MiningQueue miningQueue : robotResults) {

                List<MiningOreResult> miningOreResultList = miningQueue.getMiningOreResults();

                for (MiningOreResult miningOreResult : miningOreResultList) {

                    robotStatistics.addOre(miningOreResult.getOre(), miningOreResult.getAmount(), miningOreResult.getTax());
                }
            }
            
            robotStatisticsMap.put(robot.getId(), robotStatistics);
        }
        request.setAttribute("robotStatisticsMap", robotStatisticsMap);

        request.getRequestDispatcher("/WEB-INF/view/statistics.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet for showing statistics information on robots and players";
    }

}
