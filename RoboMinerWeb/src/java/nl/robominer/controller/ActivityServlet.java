/*
 * Copyright (C) 2014 arnoud
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
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nl.robominer.entity.MiningArea;
import nl.robominer.entity.MiningQueue;
import nl.robominer.entity.RallyResult;
import nl.robominer.session.MiningQueueFacade;
import nl.robominer.session.OreFacade;
import nl.robominer.session.RallyResultFacade;
import nl.robominer.session.UsersFacade;

/**
 *
 * @author arnoud
 */
@WebServlet(name = "ActivityServlet", urlPatterns = { "/activity" })
public class ActivityServlet extends RoboMinerServletBase
{
    /**
     * The JavaScript view used for displaying the activity page.
     */
    private static final String JAVASCRIPT_VIEW = "/WEB-INF/view/activity.jsp";

    /**
     * The JavaScript view for the rally.
     */
    private static final String JAVASCRIPT_RALLY_VIEW = "/WEB-INF/view/viewrally.jsp";

    private static final int MAX_USERS   = 5;
    private static final int MAX_RALLIES = 10;

    /**
     * Bean to handle the database actions for the user account information.
     */
    @EJB
    UsersFacade usersFacade;

    /**
     * Bean to handle the database actions for the mining queue items.
     */
    @EJB
    private MiningQueueFacade miningQueueFacade;

    /**
     * Bean to handle the database actions for the ore.
     */
    @EJB
    private OreFacade oreFacade;

    /**
     * Bean to handle the database actions for the rally result data.
     */
    @EJB
    private RallyResultFacade rallyResultFacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request  servlet request
     * @param response servlet response
     *
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        // Retrieve the requested rally, if requested
        int rallyResultId = getItemId(request, "rallyResultId");

        RallyResult rallyResult = null;

        if (rallyResultId > 0)
        {
            rallyResult = rallyResultFacade.findById(rallyResultId);
        }

        if (rallyResult != null)
        {
            showRally(request, response, rallyResult);
        }
        else
        {
            request.setAttribute("user", usersFacade.findById(getUserId(request)));
            request.setAttribute("usersList", usersFacade.findMostRecent(MAX_USERS));
            request.setAttribute("miningQueueList", miningQueueFacade.findMostRecent(MAX_RALLIES));

            request.getRequestDispatcher(JAVASCRIPT_VIEW).forward(request, response);
        }
    }

    /**
     * Show the rally animation.
     *
     * @param request      The servlet request.
     * @param response     The servlet response.
     * @param miningResult The mining queue entry to show the rally for.
     *
     * @throws ServletException if a servlet-specific error occurs.
     * @throws IOException      if an I/O error occurs.
     */
    private void showRally(HttpServletRequest request, HttpServletResponse response, RallyResult rallyResult)
        throws ServletException, IOException
    {
        // Add the rally data to the request.
        request.setAttribute("rallyData", rallyResult.getResultData());

        // Add the ore list to the request.
        request.setAttribute("oreList", oreFacade.findAll());

        // Assemble the lists or robot names and user names for the rally.
        List<String> robotNames = new ArrayList<>();
        List<String> userNames = new ArrayList<>();

        MiningArea miningArea = rallyResult.getMiningQueueList().get(0).getMiningArea();
        
        // Initialise the names as AI names.
        for (int i = 0; i < 4; ++i)
        {
            robotNames.add(miningArea.getAiRobot().getRobotName());
            userNames.add(miningArea.getAiRobot().getUser().getUsername());
        }

        // Replace the player entries with the correct names.
        for (MiningQueue miningQueue : rallyResult.getMiningQueueList())
        {
            robotNames.set(miningQueue.getPlayerNumber(), miningQueue.getRobot().getRobotName());
            userNames.set(miningQueue.getPlayerNumber(), miningQueue.getRobot().getUser().getUsername());
        }

        for (int i = 0; i < 4; ++i)
        {
            request.setAttribute("robot" + i, robotNames.get(i));
            request.setAttribute("player" + i, userNames.get(i));
        }

        request.setAttribute("user", usersFacade.findById(getUserId(request)));

        request.getRequestDispatcher(JAVASCRIPT_RALLY_VIEW).forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo()
    {
        return "The servlet showing the latest server activity";
    }
}
