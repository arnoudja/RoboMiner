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
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.HeuristicMixedException;
import javax.transaction.HeuristicRollbackException;
import javax.transaction.NotSupportedException;
import javax.transaction.RollbackException;
import javax.transaction.SystemException;
import nl.robominer.businessentity.UserAssets;
import nl.robominer.entity.Users;
import nl.robominer.session.UsersFacade;

/**
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends RoboMinerServletBase {

    /**
     * The javascript view used for displaying the leaderboard page.
     */
    private static final String JAVASCRIPT_VIEW = "/WEB-INF/view/login.jsp";

    /**
     * The name of the cookie for storing the username client-side.
     */
    private static final String REMEMBER_USERNAME_COOKIE_NAME = "remember";

    /**
     * The maximum age of the remember-username cookie, in seconds.
     */
    private static final int REMEMBER_USERNAME_COOKIE_MAXAGE = 31 * 24 * 60 * 60;

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
     * @throws ServletException if a servlet-specific error occurs.
     * @throws IOException if an I/O error occurs.
     */
    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Process a login request, if found.
        if (loginUser(request, response)) {

            response.sendRedirect("miningQueue");
        }
        // Process a signup request, if found.
        else if (!createNewUser(request, response)) {

            // No (valid) login or signup found, initialise the login page.
            Cookie[] cookies = request.getCookies();

            if (cookies != null) {

                for (Cookie cookie : cookies) {

                    if (cookie.getName().equals(REMEMBER_USERNAME_COOKIE_NAME)) {
                        request.setAttribute("loginName", cookie.getValue());
                    }
                }
            }

            request.getRequestDispatcher(JAVASCRIPT_VIEW).forward(request, response);
        }
    }

    /**
     * Process a login attempt, if found.
     *
     * @param request The servlet request.
     * @param response The servlet response.
     *
     * @return true when the user is logged in successful, false if not.
     */
    private boolean loginUser(HttpServletRequest request, HttpServletResponse response) {

        boolean result = false;

        String loginName = request.getParameter("loginName");
        String password  = request.getParameter("password");
        String remember  = request.getParameter("remember");

        Users user = usersFacade.findByUsernameOrEmail(loginName);

        if (user != null && user.verifyPassword(password)) {

            Cookie rememberCookie = new Cookie(REMEMBER_USERNAME_COOKIE_NAME, loginName);

            if (remember == null || remember.isEmpty()) {
                rememberCookie.setMaxAge(0);
            }
            else {
                rememberCookie.setMaxAge(REMEMBER_USERNAME_COOKIE_MAXAGE);
            }

            response.addCookie(rememberCookie);

            setUserId(request, user.getId());

            result = true;
        }

        return result;
    }

    /**
     * Process a create user request, if found in the request.
     *
     * @param request The servlet request.
     * @param response The servlet response.
     *
     * @return true when a user creation attempt is done, false when not.
     * Response handling is done if and only if true is returned.
     *
     * @throws ServletException if a servlet-specific error occurs.
     * @throws IOException if an I/O error occurs.
     */
    private boolean createNewUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        boolean result = false;

        String newusername      = request.getParameter("newusername");
        String email            = request.getParameter("email");
        String newpassword      = request.getParameter("newpassword");
        String confirmpassword  = request.getParameter("confirmpassword");

        if (newusername != null && email != null && newpassword != null &&
            confirmpassword != null && confirmpassword.equals(newpassword)) {

            String errorMessage = null;

            Users user = new Users();

            if (!user.setUsername(newusername)) {
                errorMessage = "Invalid username";
            }
            else if (!user.setEmail(email)) {
                errorMessage = "Invalid e-mail address";
            }
            else if (!user.setPassword(newpassword)) {
                errorMessage = "The password doesn't meet the requirements";
            }
            else {
                try {
                    UsersFacade.EWriteResult createResult = getUserAssets().createNewUser(user);

                    switch (createResult) {
                        case eDuplicateUsername:
                            errorMessage = "Username already taken, please choose another one";
                            break;

                        case eDuplicateEmail:
                            errorMessage = "You already have an account, please login using your e-mail address";
                            break;

                        case eSuccess:
                            setUserId(request, user.getId());
                            result = true;
                            response.sendRedirect("miningQueue");
                            break;
                    }
                }
                catch (NotSupportedException | SystemException | RollbackException |
                       HeuristicMixedException | HeuristicRollbackException ex) {
                    throw new ServletException(ex);
                }
            }

            if (!result) {

                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("newusername", newusername);
                request.setAttribute("email", email);
                request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
                result = true;
            }
        }

        return result;
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Login-page controller servlet";
    }

}
