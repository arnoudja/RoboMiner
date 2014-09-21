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
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nl.robominer.entity.Users;
import nl.robominer.session.UsersFacade;

/**
 * Servlet for handling account management requests.
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "AccountServlet", urlPatterns = {"/account"})
public class AccountServlet extends RoboMinerServletBase {

    /**
     * The javascript view used for displaying the account page.
     */
    private static final String JAVASCRIPT_VIEW = "/WEB-INF/view/account.jsp";

    /**
     * Bean to handle the database actions for the user.
     */
    @EJB
    private UsersFacade usersFacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request The servlet request.
     * @param response The servlet response.
     *
     * @throws ServletException if a servlet-specific error occurs.
     * @throws IOException if an I/O error occurs.
     */
    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = getUserId(request);

        processAssets(request);

        String currentpassword  = request.getParameter("currentpassword");
        String newpassword      = request.getParameter("newpassword");
        String confirmpassword  = request.getParameter("confirmpassword");

        String username         = request.getParameter("username");
        String email            = request.getParameter("email");

        Users user = usersFacade.findById(userId);

        String currentusername = user.getUsername();

        if (username == null) {
            // Ignore, assuming the page is loaded for the first time.
        }
        else if (!user.verifyPassword(currentpassword)) {
            // Only allow changes if the current password is supplied correctly
            request.setAttribute("errormessage", "Your current password doesn't match");
        }
        else {
            boolean changed = false;

            // Update the password, if applied and valid
            if (newpassword != null && confirmpassword != null &&
                confirmpassword.equals(newpassword) &&
                user.setPassword(newpassword)) {

                changed = true;
            }

            // Update the username, if changed and valid
            if (user.setUsername(username)) {
                changed = true;
            }

            // Update the email addres, if changed and valid
            if (user.setEmail(email)) {
                changed = true;
            }

            if (changed) {

                switch (usersFacade.update(user)) {
                    case eSuccess:
                        request.setAttribute("message", "Account information updated");
                        currentusername = user.getUsername();
                        break;

                    case eDuplicateUsername:
                        request.setAttribute("errormessage", "That username is already taken");
                        break;

                    case eDuplicateEmail:
                        request.setAttribute("errormessage", "Only one account per e-mail address is allowed");
                        break;
                }
            }
        }

        request.setAttribute("user", user);

        // The username in 'user' might have been changed but not saved to the database yet, so provide the database username separately
        request.setAttribute("currentusername", currentusername);

        request.getRequestDispatcher(JAVASCRIPT_VIEW).forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet for processing account management requests";
    }

}
