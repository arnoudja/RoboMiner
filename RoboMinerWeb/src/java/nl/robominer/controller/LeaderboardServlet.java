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
import nl.robominer.entity.MiningArea;
import nl.robominer.entity.RobotMiningAreaScore;
import nl.robominer.session.MiningAreaFacade;
import nl.robominer.session.RobotMiningAreaScoreFacade;
import nl.robominer.session.TopRobotsViewFacade;
import nl.robominer.session.UsersFacade;

/**
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "LeaderboardServlet", urlPatterns = {"/leaderboard"})
public class LeaderboardServlet extends RoboMinerServletBase {

    /**
     * The javascript view used for displaying the leaderboard page.
     */
    private static final String JAVASCRIPT_VIEW = "/WEB-INF/view/leaderboard.jsp";

    /**
     * The maximum number of entries to retrieve for each score type.
     */
    private static final int MAX_ENTRIES = 10;

    /**
     * Ignore entries for values with less rally runs than this.
     */
    private static final int MIN_RUNS    = 3;

    /**
     * Bean to handle the database actions for the top robots database view.
     */
    @EJB
    TopRobotsViewFacade topRobotsViewFacade;

    /**
     * Bean to handle the database actions for the mining areas.
     */
    @EJB
    MiningAreaFacade miningAreaFacade;

    /**
     * Bean to handle the database actions for the robot mining scores.
     */
    @EJB
    RobotMiningAreaScoreFacade robotMiningAreaScoreFacade;

    /**
     * Bean to handle the database actions for the user account information.
     */
    @EJB
    UsersFacade usersFacade;

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

        // Add the list of top robots to the request.
        request.setAttribute("topRobotsList", topRobotsViewFacade.getTopRobots(MAX_ENTRIES, MIN_RUNS));

        // Add the list of mining areas to the request.
        List<MiningArea> miningAreaList = miningAreaFacade.findAll();
        request.setAttribute("miningAreaList", miningAreaList);

        // Add the mapping of mining area to the list of robot scores.
        Map<Integer, List<RobotMiningAreaScore> > robotMiningAreaScoreMap = new HashMap<>();
        for (MiningArea miningArea : miningAreaList) {
            robotMiningAreaScoreMap.put(miningArea.getId(), robotMiningAreaScoreFacade.findByMiningAreaId(miningArea.getId(), MIN_RUNS, MAX_ENTRIES));
        }
        request.setAttribute("robotMiningAreaScoreMap", robotMiningAreaScoreMap);

        request.setAttribute("user", usersFacade.findById(getUserId(request)));

        request.getRequestDispatcher(JAVASCRIPT_VIEW).forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "The servlet showing the best robots and players";
    }

}
