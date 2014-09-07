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
import java.util.List;
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
import nl.robominer.entity.MiningQueue;
import nl.robominer.entity.UserOreAsset;
import nl.robominer.session.MiningQueueFacade;
import nl.robominer.session.OreFacade;

/**
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "MiningResultsServlet", urlPatterns = {"/miningResults"})
public class MiningResultsServlet extends RoboMinerServletBase {

    @EJB
    private MiningQueueFacade miningQueueFacade;
    
    @EJB
    private OreFacade oreFacade;
    
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
        
        String rallyResultId = request.getParameter("rallyResultId");
        MiningQueue miningResult = null;
        
        if (rallyResultId != null) {
            miningResult = miningQueueFacade.findByRallyAndUsersId(Integer.parseInt(rallyResultId), userId);
        }

        if (miningResult == null) {

            processAssets(request);
        
            // Add the list of mining queue items
            List<MiningQueue> miningResultsList = miningQueueFacade.findResultsByUsersId(userId);
            request.setAttribute("miningResultsList", miningResultsList);

            request.getRequestDispatcher("/WEB-INF/view/miningresults.jsp").forward(request, response);
        }
        else {
            request.setAttribute("rallyData", miningResult.getRallyResult().getResultData());
            request.setAttribute("oreList", oreFacade.findAll());
            
            List<String> robotNames = new ArrayList<>();
            List<String> userNames = new ArrayList<>();
            
            for (int i = 0; i < 4; ++i) {
                robotNames.add(miningResult.getMiningArea().getAiRobot().getRobotName());
                userNames.add(miningResult.getMiningArea().getAiRobot().getUser().getUsername());
            }
            
            for (MiningQueue miningQueue : miningResult.getRallyResult().getMiningQueueList()) {
                robotNames.set(miningQueue.getPlayerNumber(), miningQueue.getRobot().getRobotName());
                userNames.set(miningQueue.getPlayerNumber(), miningQueue.getRobot().getUser().getUsername());
            }

            for (int i = 0; i < 4; ++i) {
                request.setAttribute("robot" + i, robotNames.get(i));
                request.setAttribute("player" + i, userNames.get(i));
            }
            
            request.getRequestDispatcher("/WEB-INF/view/viewrally.jsp").forward(request, response);
        }
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
