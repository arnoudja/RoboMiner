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
import nl.robominer.entity.MiningQueue;
import nl.robominer.entity.ProgramSource;
import nl.robominer.entity.Robot;
import nl.robominer.entity.Users;
import nl.robominer.session.MiningQueueFacade;
import nl.robominer.session.ProgramSourceFacade;
import nl.robominer.session.RoboMinerCppBean;
import nl.robominer.session.RobotFacade;
import nl.robominer.session.UsersFacade;

/**
 * Servlet for handling program source requests.
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "EditCodeServlet", urlPatterns = {"/editCode"})
public class EditCodeServlet extends RoboMinerServletBase {

    /**
     * The javascript view used for displaying the program source page.
     */
    private static final String JAVASCRIPT_VIEW = "/WEB-INF/view/editcode.jsp";

    /**
     * The session attribute id for storing the selected program.
     */
    private static final String SESSION_PROGRAM_SOURCE_ID = "editCode_programSourceId";

    /**
     * Bean to handle the database actions for the program source information.
     */
    @EJB
    private ProgramSourceFacade programSourceFacade;
    
    /**
     * Bean to handle the database actions for the robot information.
     */
    @EJB
    private RobotFacade robotFacade;
    
    /**
     * Bean to handle the database actions for the mining queue information.
     */
    @EJB
    private MiningQueueFacade miningQueueFacade;
    
    /**
     * Bean to handle the database actions for the user information.
     */
    @EJB
    private UsersFacade usersFacade;

    /**
     * Bean to handle the access to the c++ part of the program.
     */
    @EJB
    private RoboMinerCppBean roboMinerCppBean;

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

        Users user = usersFacade.findById(getUserId(request));

        String requestType      = request.getParameter("requestType");
        int programSourceId     = getItemId(request, "programSourceId");
        int nextProgramSourceId = getItemId(request, "nextProgramSourceId");
        String sourceName       = request.getParameter("sourceName");
        String sourceCode       = request.getParameter("sourceCode");

        if ("erase".equals(requestType)) {

            ProgramSource programSource = user.getProgramSource(programSourceId);
            if (programSource != null && programSource.getRobotList().isEmpty()) {

                programSourceFacade.remove(programSource);
                nextProgramSourceId = 0;
            }
        }
        else if (sourceName != null && !sourceName.isEmpty() &&
                 sourceCode != null && !sourceCode.isEmpty()) {

            if (programSourceId > 0) {
                String errorMessage = updateProgramSource(user.getProgramSource(programSourceId), sourceName, sourceCode);
                if (!errorMessage.isEmpty()) {
                    request.setAttribute("errorMessage", errorMessage);
                }
            }
            else {

                programSourceId = addProgramSource(user.getId(), sourceName, sourceCode);

                if (nextProgramSourceId <= 0) {
                    nextProgramSourceId = programSourceId;
                }
            }
        }

        // Force a refresh on the user instance to update the program list.
        user = usersFacade.findById(getUserId(request));

        ProgramSource programSource = null;

        if (nextProgramSourceId >= 0) {

            programSource = user.getProgramSource(nextProgramSourceId);

            if (programSource == null && request.getSession().getAttribute(SESSION_PROGRAM_SOURCE_ID) != null) {
                nextProgramSourceId = (int)request.getSession().getAttribute(SESSION_PROGRAM_SOURCE_ID);
                programSource       = user.getProgramSource(nextProgramSourceId);
            }

            if (programSource == null && !user.getProgramSourceList().isEmpty()) {
                programSource       = user.getProgramSourceList().get(0);
                nextProgramSourceId = programSource.getId();
            }
        }

        if (programSource == null) {

            // Retrieve defaults.
            nextProgramSourceId = -1;

            programSource = new ProgramSource(user.getId());
        }

        // Add the data of the user to the request.
        request.setAttribute("user", user);

        // Add the data of the currently selected source to the request.
        request.setAttribute("programSourceId", nextProgramSourceId);
        request.setAttribute("programSource", programSource);

        // Save the selected program id in the session
        request.getSession().setAttribute(SESSION_PROGRAM_SOURCE_ID, nextProgramSourceId);

        request.getRequestDispatcher(JAVASCRIPT_VIEW).forward(request, response);
    }

    /**
     * Update the program source in the database and check its validity.
     *
     * @param programSource The program source to update.
     * @param sourceName The new program source name.
     * @param sourceCode The new program source code.
     *
     * @return The warning message specifying the robots that are using this
     * program but couldn't be updated, or empty if none.
     */
    private String updateProgramSource(ProgramSource programSource, String sourceName, String sourceCode) {

        StringBuilder errorMessage = new StringBuilder();

        if (programSource != null) {

            programSource.setSourceName(sourceName);
            programSource.setSourceCode(sourceCode);
            programSource.setVerified(false);

            // Communicate with the c++ part over the database to verify the code.
            programSourceFacade.edit(programSource);
            roboMinerCppBean.verifyCode(getServletContext().getRealPath("/WEB-INF/binaries/robominercpp"), programSource.getId());
            programSource = programSourceFacade.find(programSource.getId());

            if (programSource.getVerified()) {

                List<Robot> robotList = programSource.getRobotList();

                for (Robot robot : robotList) {

                    List<MiningQueue> miningQueue = miningQueueFacade.findWaitingByRobotId(robot.getId());

                    if (miningQueue.isEmpty() && robot.getMemorySize() >= programSource.getCompiledSize()) {

                        robot.setSourceCode(programSource.getSourceCode());
                        robotFacade.edit(robot);
                    }
                    else {

                        errorMessage.append("Unable to apply the code to robot ").append(robot.getRobotName()).append(": ");

                        if (robot.getMemorySize() < programSource.getCompiledSize()) {
                            errorMessage.append("Not enough memory.");
                        }
                        else {
                            errorMessage.append("The robot is busy.");
                        }

                        errorMessage.append("\\n");
                    }
                }
            }
        }
        
        return errorMessage.toString();
    }

    /**
     * Add a new program source instance to the database.
     *
     * @param userId The id of the user the program source is for.
     * @param sourceName The name of the new program source.
     * @param sourceCode The code of the new program source.
     *
     * @return The id value of the new program source instance created.
     */
    private int addProgramSource(int userId, String sourceName, String sourceCode) {

        ProgramSource programSource = new ProgramSource(userId);

        programSource.setSourceName(sourceName);
        programSource.setSourceCode(sourceCode);
        programSource.setVerified(false);

        programSourceFacade.create(programSource);
        roboMinerCppBean.verifyCode(getServletContext().getRealPath("/WEB-INF/binaries/robominercpp"), programSource.getId());

        return programSource.getId();
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Robot-program code-edit controller servlet";
    }

}
