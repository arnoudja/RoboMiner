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
import nl.robominer.session.MiningQueueFacade;
import nl.robominer.session.ProgramSourceFacade;
import nl.robominer.session.RoboMinerCppBean;
import nl.robominer.session.RobotFacade;

/**
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "EditCodeServlet", urlPatterns = {"/editCode"})
public class EditCodeServlet extends RoboMinerServletBase {

    @EJB
    private ProgramSourceFacade programSourceFacade;
    
    @EJB
    private RobotFacade robotFacade;
    
    @EJB
    private MiningQueueFacade miningQueueFacade;
    
    @EJB
    private RoboMinerCppBean roboMinerCppBean;

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
        
        int programSourceId = getItemId(request, "programSourceId");
        int nextProgramSourceId = getItemId(request, "nextProgramSourceId");
        String sourceName = request.getParameter("sourceName");
        String sourceCode = request.getParameter("sourceCode");
        
        if (sourceName != null && sourceCode != null) {
            
            if (programSourceId > 0) {
                String errorMessage = updateProgramSource(userId, programSourceId, sourceName, sourceCode);
                if (!errorMessage.isEmpty()) {
                    request.setAttribute("errorMessage", errorMessage);
                }
            }
            else {
                
                programSourceId = addProgramSource(userId, sourceName, sourceCode);
                
                if (nextProgramSourceId <= 0) {
                    
                    nextProgramSourceId = programSourceId;
                }
            }
        }
        
        // Add the list of program sources
        List<ProgramSource> programSourceList = programSourceFacade.findByUsersId(userId);
        request.setAttribute("programSourceList", programSourceList);

        // When the page is opened for the first time, open the first program on the list
        if (nextProgramSourceId == 0 && !programSourceList.isEmpty()) {
            
            nextProgramSourceId = programSourceList.get(0).getId();
        }
        
        ProgramSource programSource = null;
        
        if (nextProgramSourceId > 0) {
            programSource = programSourceFacade.findByIdAndUser(nextProgramSourceId, userId);
        }

        // Retrieve defaults, if requested
        if (programSource == null) {

            nextProgramSourceId = -1;
            
            programSource = new ProgramSource();
            programSource.fillDefaults();
            programSource.setUsersId(userId);
        }
        
        // Add the data of the currently selected source
        request.setAttribute("programSourceId", nextProgramSourceId);
        request.setAttribute("programSource", programSource);

        request.getRequestDispatcher("/WEB-INF/view/editcode.jsp").forward(request, response);
    }

    private String updateProgramSource(int userId, int programSourceId, String sourceName, String sourceCode) {
        
        ProgramSource programSource = programSourceFacade.find(programSourceId);
        
        StringBuilder errorMessage = new StringBuilder();
            
        if (programSource != null && programSource.getUsersId() == userId) {

            programSource.setSourceName(sourceName);
            programSource.setSourceCode(sourceCode);
            programSource.setVerified(false);

            programSourceFacade.edit(programSource);
            roboMinerCppBean.verifyCode(getServletContext().getRealPath("/WEB-INF/binaries/robominercpp"), programSource.getId());

            // Reload the verified version
            programSource = programSourceFacade.findByIdAndUser(programSourceId, userId);

            if (programSource.getVerified()) {

                List<Robot> robotList = robotFacade.findByProgramAndUser(programSourceId, userId);

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
    
    private int addProgramSource(int userId, String sourceName, String sourceCode) {
        
        ProgramSource programSource = new ProgramSource();
        
        programSource.setUsersId(userId);
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
