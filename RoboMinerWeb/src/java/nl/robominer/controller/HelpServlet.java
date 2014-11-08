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
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nl.robominer.session.UsersFacade;

/**
 *
 * @author arnoud
 */
@WebServlet(name = "HelpServlet", urlPatterns = { "/help" })
public class HelpServlet extends RoboMinerServletBase
{
    /**
     * The JavaScript view used for displaying the activity page.
     */
    private static final String JAVASCRIPT_VIEW = "/WEB-INF/view/help.jsp";

    /**
     * Bean to handle the database actions for the user account information.
     */
    @EJB
    UsersFacade usersFacade;

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
        request.setAttribute("user", usersFacade.findById(getUserId(request)));

        request.getRequestDispatcher(JAVASCRIPT_VIEW).forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo()
    {
        return "Servlet for showing the help index";
    }
}
