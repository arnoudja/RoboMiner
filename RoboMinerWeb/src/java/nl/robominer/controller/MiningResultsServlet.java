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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nl.robominer.entity.MiningQueue;
import nl.robominer.entity.Robot;
import nl.robominer.session.MiningQueueFacade;
import nl.robominer.session.OreFacade;
import nl.robominer.session.RobotFacade;

/**
 * Servlet for handing the mining results view and the rally view.
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "MiningResultsServlet", urlPatterns = {"/miningResults"})
public class MiningResultsServlet extends RoboMinerServletBase {

    /**
     * The JavaScript view for the mining result lists.
     */
    private static final String JAVASCRIPT_RESULTLISTS_VIEW = "/WEB-INF/view/miningresults.jsp";

    /**
     * The JavaScript view for the rally.
     */
    private static final String JAVASCRIPT_RALLY_VIEW       = "/WEB-INF/view/viewrally.jsp";

    /**
     * The maximum number of mining results to show for each robot.
     */
    private static final int MAX_RESULTS = 10;

    /**
     * Bean to handle the database actions for the robots.
     */
    @EJB
    private RobotFacade robotFacade;

    /**
     * Bean to handle the database actions for the mining results.
     */
    @EJB
    private MiningQueueFacade miningQueueFacade;

    /**
     * Bean to handle the database actions for the ore.
     */
    @EJB
    private OreFacade oreFacade;

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

        int userId = getUserId(request);

        // Retrieve the requested rally, if requested
        int rallyResultId = getItemId(request, "rallyResultId");

        MiningQueue miningResult = null;

        if (rallyResultId > 0) {
            miningResult = miningQueueFacade.findByRallyAndUsersId(rallyResultId, userId);
        }

        if (miningResult == null) {

            // No (valid) rally view requested, show the lists of rally results
            showResultLists(request, response, userId);
        }
        else {

            // Process the rally view request
            showRally(request, response, miningResult);
        }
    }

    /**
     * Show the rally result list for each robot.
     * 
     * @param request The servlet request.
     * @param response The servlet response.
     * @param userId The id of the user to show the result lists for.
     * 
     * @throws ServletException if a servlet-specific error occurs.
     * @throws IOException if an I/O error occurs.
     */
    private void showResultLists(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {

        processAssets(request);

        // Add the list of robots
        List<Robot> robotList = robotFacade.findByUsersId(userId);
        request.setAttribute("robotList", robotList);

        // Add the map of robot id - mining results list
        Map< Integer, List<MiningQueue> > miningResultListMap = new HashMap<>();
        for (Robot robot : robotList) {
            miningResultListMap.put(robot.getId(), miningQueueFacade.findResultsByRobotId(robot.getId(), MAX_RESULTS));
        }
        request.setAttribute("miningResultListMap", miningResultListMap);

        request.getRequestDispatcher(JAVASCRIPT_RESULTLISTS_VIEW).forward(request, response);
    }

    /**
     * Show the rally animation.
     * 
     * @param request The servlet request.
     * @param response The servlet response.
     * @param miningResult The mining queue entry to show the rally for.
     * 
     * @throws ServletException if a servlet-specific error occurs.
     * @throws IOException if an I/O error occurs.
     */
    private void showRally(HttpServletRequest request, HttpServletResponse response, MiningQueue miningResult)
            throws ServletException, IOException {

        // Add the rally data to the request.
        request.setAttribute("rallyData", miningResult.getRallyResult().getResultData());

        // Add the ore list to the request.
        request.setAttribute("oreList", oreFacade.findAll());

        // Assemble the lists or robot names and user names for the rally.
        List<String> robotNames = new ArrayList<>();
        List<String> userNames = new ArrayList<>();

        // Initialise the names as AI names.
        for (int i = 0; i < 4; ++i) {
            robotNames.add(miningResult.getMiningArea().getAiRobot().getRobotName());
            userNames.add(miningResult.getMiningArea().getAiRobot().getUser().getUsername());
        }

        // Replace the player entries with the correct names.
        for (MiningQueue miningQueue : miningResult.getRallyResult().getMiningQueueList()) {
            robotNames.set(miningQueue.getPlayerNumber(), miningQueue.getRobot().getRobotName());
            userNames.set(miningQueue.getPlayerNumber(), miningQueue.getRobot().getUser().getUsername());
        }

        for (int i = 0; i < 4; ++i) {
            request.setAttribute("robot" + i, robotNames.get(i));
            request.setAttribute("player" + i, userNames.get(i));
        }

        request.getRequestDispatcher(JAVASCRIPT_RALLY_VIEW).forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Mining results overview controller servlet";
    }

}
