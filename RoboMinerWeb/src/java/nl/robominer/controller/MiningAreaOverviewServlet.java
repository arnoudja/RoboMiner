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
import nl.robominer.entity.MiningArea;
import nl.robominer.entity.Ore;
import nl.robominer.session.MiningAreaFacade;
import nl.robominer.session.OreFacade;
import nl.robominer.session.UsersFacade;

/**
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "MiningAreaOverviewServlet", urlPatterns = {"/miningAreaOverview"})
public class MiningAreaOverviewServlet extends RoboMinerServletBase {

    @EJB
    private OreFacade oreFacade;

    @EJB
    private MiningAreaFacade miningAreaFacade;

    @EJB
    private UsersFacade usersFacade;

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

        // Add the list of ore
        List<Ore> oreList = oreFacade.findAll();
        request.setAttribute("oreList", oreList);

        // Add the list of mining areas
        List<MiningArea> miningAreaList = miningAreaFacade.findAll();
        request.setAttribute("miningAreaList", miningAreaList);

        request.setAttribute("user", usersFacade.findById(getUserId(request)));

        request.getRequestDispatcher("/WEB-INF/view/miningareaoverview.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "An overview of the statistics of all mining areas";
    }

}
