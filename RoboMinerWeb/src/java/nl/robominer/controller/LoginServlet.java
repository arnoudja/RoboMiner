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

import bcrypt.BCrypt;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nl.robominer.entity.ProgramSource;
import nl.robominer.entity.Robot;
import nl.robominer.entity.RobotPart;
import nl.robominer.entity.UserAchievement;
import nl.robominer.entity.UserRobotPartAsset;
import nl.robominer.entity.Users;
import nl.robominer.session.ProgramSourceFacade;
import nl.robominer.session.RoboMinerCppBean;
import nl.robominer.session.RobotFacade;
import nl.robominer.session.RobotPartFacade;
import nl.robominer.session.UserAchievementFacade;
import nl.robominer.session.UserRobotPartAssetFacade;
import nl.robominer.session.UsersFacade;

/**
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends RoboMinerServletBase {

    private static final String rememberCookieName = "remember";
    private static final int maxRememberCookieAge = 31 * 24 * 60 * 60;
    
    @EJB
    private UsersFacade usersFacade;

    @EJB
    private ProgramSourceFacade programSourceFacade;
    
    @EJB
    private RobotFacade robotFacade;

    @EJB
    private RobotPartFacade robotPartFacade;

    @EJB
    private UserRobotPartAssetFacade userRobotPartAssetFacade;
    
    @EJB
    private RoboMinerCppBean roboMinerCppBean;

    @EJB
    private UserAchievementFacade userAchievementFacade;

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

        if (loginUser(request, response)) {

            response.sendRedirect("miningQueue");
        }
        else if (!createNewUser(request, response)) {

            Cookie[] cookies = request.getCookies();
            
            if (cookies != null) {

                for (Cookie cookie : cookies) {

                    if (cookie.getName().equals(rememberCookieName)) {
                        request.setAttribute("loginName", cookie.getValue());
                    }
                }
            }

            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }

    private boolean loginUser(HttpServletRequest request, HttpServletResponse response) {

        boolean result = false;

        String loginName = request.getParameter("loginName");
        String password  = request.getParameter("password");
        String remember  = request.getParameter("remember");

        Users user = usersFacade.findByUsernameOrEmail(loginName);

        if (user != null && BCrypt.checkpw(password, user.getPassword())) {

            Cookie rememberCookie = new Cookie(rememberCookieName, loginName);

            if (remember == null || remember.isEmpty()) {
                rememberCookie.setMaxAge(0);
            }
            else {
                rememberCookie.setMaxAge(maxRememberCookieAge);
            }

            response.addCookie(rememberCookie);

            setUserId(request, user.getId());

            result = true;
        }

        return result;
    }

    private boolean createNewUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        boolean result = false;
        String errorMessage = null;

        String newusername      = request.getParameter("newusername");
        String email            = request.getParameter("email");
        String newpassword      = request.getParameter("newpassword");
        String confirmpassword  = request.getParameter("confirmpassword");

        if (newusername != null && newusername.matches("[A-Za-z0-9]{3,30}") &&
            email != null && email.matches(".+@.+") &&
            newpassword != null && newpassword.length() >= 8 &&
            confirmpassword != null && confirmpassword.equals(newpassword)) {

            if (usersFacade.findByUsername(newusername) != null) {
                errorMessage = "Username already taken, please choose another one";
            }
            else if (usersFacade.findByEmail(email) != null) {
                errorMessage = "You already have an account, please login using your e-mail address";
            }
            else {
                Users newuser = new Users();
                newuser.setUsername(newusername);
                newuser.setEmail(email);
                newuser.setPassword(BCrypt.hashpw(newpassword, BCrypt.gensalt()));
                newuser.setMiningQueueSize(1);

                try {
                    usersFacade.create(newuser);

                    addNewUserData(newuser);

                    setUserId(request, newuser.getId());

                    result = true;

                    response.sendRedirect("miningQueue");
                }
                catch (javax.ejb.EJBException exc) {
                    throw new ServletException(exc);
                }
            }
        }
        
        if (errorMessage != null) {
            
            request.setAttribute("errorMessage", errorMessage);
            request.setAttribute("newusername", newusername);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
            result = true;
        }
            
        return result;
    }

    private void addNewUserData(Users user) {

        // Create a new program for the user
        ProgramSource programSource = new ProgramSource();
        programSource.fillDefaults();
        programSource.setSourceName("Program 1");
        programSource.setUsersId(user.getId());
        programSourceFacade.create(programSource);
        roboMinerCppBean.verifyCode(getServletContext().getRealPath("/WEB-INF/binaries/robominercpp"), programSource.getId());

        // Retrieve the initial robot parts
        RobotPart oreContainer  = robotPartFacade.find(101);
        RobotPart miningUnit    = robotPartFacade.find(201);
        RobotPart battery       = robotPartFacade.find(301);
        RobotPart memoryModule  = robotPartFacade.find(401);
        RobotPart cpu           = robotPartFacade.find(501);
        RobotPart engine        = robotPartFacade.find(601);

        // Add the initial robot parts for the user
        userRobotPartAssetFacade.create(new UserRobotPartAsset(user.getId(), oreContainer.getId(), 1, 0));
        userRobotPartAssetFacade.create(new UserRobotPartAsset(user.getId(), miningUnit.getId(), 1, 0));
        userRobotPartAssetFacade.create(new UserRobotPartAsset(user.getId(), battery.getId(), 1, 0));
        userRobotPartAssetFacade.create(new UserRobotPartAsset(user.getId(), memoryModule.getId(), 1, 0));
        userRobotPartAssetFacade.create(new UserRobotPartAsset(user.getId(), cpu.getId(), 1, 0));
        userRobotPartAssetFacade.create(new UserRobotPartAsset(user.getId(), engine.getId(), 1, 0));

        // Create a robot for the user
        Robot robot = new Robot();
        robot.fillDefaults(oreContainer, miningUnit, battery, memoryModule, cpu, engine);
        robot.setRobotName("Robot1");
        robot.setUser(user);
        robot.setProgramSourceId(programSource.getId());
        robotFacade.create(robot);

        // Add the first achievement
        UserAchievement userAchievement = new UserAchievement(user.getId(), 1);
        userAchievementFacade.create(userAchievement);
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
