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
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nl.robominer.businessentity.MiningQueueItem;
import nl.robominer.businessentity.MiningQueueItem.EMiningQueueItemStatus;
import nl.robominer.entity.MiningArea;
import nl.robominer.entity.MiningQueue;
import nl.robominer.entity.Robot;
import nl.robominer.entity.Users;
import nl.robominer.session.MiningAreaFacade;
import nl.robominer.session.MiningQueueFacade;
import nl.robominer.session.RobotFacade;
import nl.robominer.session.UsersFacade;

/**
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "MiningQueueServlet", urlPatterns = {"/miningQueue"})
public class MiningQueueServlet extends RoboMinerServletBase {

    private static final String SESSION_INFO_MINING_AREA_ID = "miningQueue_infoMiningAreaId";
    private static final String SESSION_ROBOT_MINING_AREA_ID = "miningQueue_robotMiningAreaId";

    @EJB
    private UsersFacade usersFacade;

    @EJB
    private MiningQueueFacade miningQueueFacade;

    @EJB
    private RobotFacade robotFacade;

    @EJB
    private MiningAreaFacade miningAreaFacade;

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

        processAssets(request);

        String errorMessage = null;

        String submitType = request.getParameter("submitType");
        String[] selectedQueueItems = request.getParameterValues("selectedQueueItemId");
        int miningAreaId = getItemId(request, "miningAreaId");
        int robotId = getItemId(request, "robotId");

        if (submitType != null) {
            switch (submitType) {
                case "add":
                    errorMessage = addMiningQueueItem(request, userId, robotId, getItemId(request, "miningAreaAddId"));
                    break;

                case "remove":
                    if (selectedQueueItems != null) {
                        removeMiningQueueItems(userId, robotId, selectedQueueItems);
                    }
                    break;
            }
        }

        // Add the user item
        Users user = usersFacade.findById(userId);
        request.setAttribute("user", user);

        // Add the list of robots
        List<Robot> robotList = robotFacade.findByUsersId(userId);
        request.setAttribute("robotList", robotList);

        // Add the map of mining queue items per robot id
        int largestQueueSize = 0;
        Map<Integer, List<MiningQueueItem> > robotMiningQueueMap = new HashMap<>();
        for (Robot robot : robotList) {
            List<MiningQueueItem> robotQueueList = getQueueInfo(miningQueueFacade.findWaitingByRobotId(robot.getId()), selectedQueueItems);
            robotMiningQueueMap.put(robot.getId(), robotQueueList);
            largestQueueSize = Math.max(largestQueueSize, robotQueueList.size());
        }
        request.setAttribute("robotMiningQueueMap", robotMiningQueueMap);
        request.setAttribute("largestQueueSize", largestQueueSize);
        request.setAttribute("maxQueueSize", user.getMiningQueueSize());

        // Add the list of mining areas
        List<MiningArea> miningAreaList = miningAreaFacade.findAll();
        request.setAttribute("miningAreaList", miningAreaList);

        // Restore the session selection or select first mining area from the lists when none selected yet
        if (miningAreaId <= 0) {

            if (request.getSession().getAttribute(SESSION_INFO_MINING_AREA_ID) != null) {
                miningAreaId = (int)request.getSession().getAttribute(SESSION_INFO_MINING_AREA_ID);
            }
            else if (!miningAreaList.isEmpty()) {
                miningAreaId = miningAreaList.get(0).getId();
            }
        }

        // Determine the selected mining area for each robot
        Map<Integer, Integer> sessionRobotMiningAreaId = (Map<Integer, Integer>)request.getSession().getAttribute(SESSION_ROBOT_MINING_AREA_ID);
        Map<Integer, Integer> robotMiningAreaId = new HashMap<>();

        for (Robot robot : robotList) {

            int selectedMiningAreaId = getItemId(request, "miningArea" + robot.getId());

            if (selectedMiningAreaId <= 0) {

                if (sessionRobotMiningAreaId != null && sessionRobotMiningAreaId.get(robot.getId()) != null) {
                    selectedMiningAreaId = sessionRobotMiningAreaId.get(robot.getId());
                }
                else if (!miningAreaList.isEmpty()) {
                    selectedMiningAreaId = miningAreaList.get(0).getId();
                }
            }

            robotMiningAreaId.put(robot.getId(), selectedMiningAreaId);
        }

        // Add the previous selected ids
        request.setAttribute("miningAreaId", miningAreaId);
        request.setAttribute("selectedQueueItems", selectedQueueItems);
        request.setAttribute("robotMiningAreaId", robotMiningAreaId);

        // Add the error message
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
        }

        // Store the selections in the session
        request.getSession().setAttribute(SESSION_ROBOT_MINING_AREA_ID, robotMiningAreaId);
        request.getSession().setAttribute(SESSION_INFO_MINING_AREA_ID, miningAreaId);

        request.getRequestDispatcher("/WEB-INF/view/miningqueue.jsp").forward(request, response);
    }

    private String addMiningQueueItem(HttpServletRequest request, int userId, int robotId, int miningAreaId) throws ServletException {

        String errorMessage = null;

        List<MiningQueue> robotMiningQueueList = miningQueueFacade.findWaitingByRobotId(robotId);
        Robot robot = robotFacade.find(robotId);

        if (robot.getUser().getId() != userId) {
            robot = null;
        }

        MiningArea miningArea = miningAreaFacade.find(miningAreaId);

        if (robot == null) {
            errorMessage = "Unknown robot";
        }
        else if (miningArea == null) {
            errorMessage = "Unknown mining area";
        }
        else if (robotMiningQueueList.size() >= robot.getUser().getMiningQueueSize())
        {
            errorMessage = "Unable to add to the mining queue: The mining queue is full.";
        }
        else {

            if (payMiningCosts(request, userId, miningArea)) {

                MiningQueue miningQueue = new MiningQueue();
                miningQueue.setMiningArea(miningArea);
                miningQueue.setRobot(robot);

                miningQueueFacade.create(miningQueue);
            }
            else {
                errorMessage = "Unable to add to the mining queue: You do not have enough funds to pay the mining costs.";
            }
        }

        return errorMessage;
    }

    private void removeMiningQueueItems(int userId, int robotId, String[] selectedQueueItems) {
        List<MiningQueueItem> miningQueueList = getQueueInfo(miningQueueFacade.findWaitingByUsersId(userId), selectedQueueItems);

        for (MiningQueueItem item : miningQueueList) {
            if (item.isSelected() && item.getMiningQueue().getRobot().getId() == robotId && item.getItemStatus() == EMiningQueueItemStatus.QUEUED) {
                miningQueueFacade.remove(item.getMiningQueue());
            }
        }
    }

    private List<MiningQueueItem> getQueueInfo(List<MiningQueue> miningQueueList, String[] selectedItems) {
        
        List<MiningQueueItem> result = new LinkedList<>();
        
        Map<Integer, Long> robotTimeLeft = new HashMap<>();
        
        for (MiningQueue miningQueue : miningQueueList)
        {
            boolean selected = false;
            
            if (selectedItems != null) {
                for (String item : selectedItems) {
                    if (miningQueue.getId() == Integer.parseInt(item)) {
                        selected = true;
                    }
                }
            }
            
            Robot robot = miningQueue.getRobot();
            
            if (!robotTimeLeft.containsKey(robot.getId())) {
                
                Date now = new Date();
                if (robot.getRechargeEndTime().after(now) &&
                    (robot.getMiningEndTime() == null ||
                     robot.getMiningEndTime().before(now) ||
                     robot.getMiningEndTime().after(robot.getRechargeEndTime()) )) {
                    
                    long timeLeft = (robot.getRechargeEndTime().getTime() - now.getTime()) / 1000;
                    if (timeLeft <= 0) {
                        
                        timeLeft = 1;
                    }
                    
                    result.add(new MiningQueueItem(miningQueue, EMiningQueueItemStatus.RECHARGING, timeLeft, selected));
                    
                    timeLeft += miningQueue.getMiningArea().getMiningTime();
                    
                    robotTimeLeft.put(robot.getId(), timeLeft);
                }
                else {
                    
                    long timeLeft;
                    
                    if (robot.getMiningEndTime() != null && robot.getMiningEndTime().after(now)) {
                        
                        timeLeft = (robot.getMiningEndTime().getTime() - now.getTime()) / 1000;
                    }
                    else {
                    
                        Date miningStart = robot.getRechargeEndTime().after(miningQueue.getCreationTime()) ? robot.getRechargeEndTime() : miningQueue.getCreationTime();
                    
                        timeLeft = (miningStart.getTime() - now.getTime()) / 1000 + miningQueue.getMiningArea().getMiningTime();
                    }
                    
                    if (timeLeft > 0) {
                        
                        result.add(new MiningQueueItem(miningQueue, EMiningQueueItemStatus.MINING, timeLeft, selected));
                        
                        robotTimeLeft.put(robot.getId(), timeLeft);
                    }
                    else {
                        
                        result.add(new MiningQueueItem(miningQueue, EMiningQueueItemStatus.UPDATING, 1, selected));
                    
                        robotTimeLeft.put(robot.getId(), 1L);
                    }
                }
            }
            else {
                
                long timeLeft = robotTimeLeft.get(robot.getId());
                
                timeLeft += miningQueue.getRobot().getRechargeTime() + miningQueue.getMiningArea().getMiningTime();
                
                result.add(new MiningQueueItem(miningQueue, EMiningQueueItemStatus.QUEUED, timeLeft, selected));
                
                robotTimeLeft.put(robot.getId(), timeLeft);
            }
        }
        
        return result;
    }

    Map<Integer, Integer> getQueueSizes(List<MiningQueueItem> miningQueueList) {
        
        Map<Integer, Integer> result = new HashMap<>();
        
        for (MiningQueueItem queueItem : miningQueueList) {
            
            int robotId = queueItem.getMiningQueue().getRobot().getId();
            Integer items = result.get(robotId);
            
            if (items == null) {
                result.put(robotId, 1);
            }
            else {
                result.put(robotId, items + 1);
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
        return "Mining Queue Servlet";
    }

}
