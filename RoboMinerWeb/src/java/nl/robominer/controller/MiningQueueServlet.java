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
import javax.transaction.HeuristicMixedException;
import javax.transaction.HeuristicRollbackException;
import javax.transaction.NotSupportedException;
import javax.transaction.RollbackException;
import javax.transaction.SystemException;
import nl.robominer.businessentity.MiningQueueItem;
import nl.robominer.businessentity.MiningQueueItem.EMiningQueueItemStatus;
import nl.robominer.businessentity.UserAssets;
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

    @EJB
    private UsersFacade usersFacade;
    
    @EJB
    private MiningQueueFacade miningQueueFacade;
    
    @EJB
    private RobotFacade robotFacade;
    
    @EJB
    private MiningAreaFacade miningAreaFacade;
    
    @EJB
    private UserAssets userAssets;

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

        try {
            userAssets.updateUserAssets(userId);
        }
        catch (IllegalStateException | SecurityException | HeuristicMixedException | HeuristicRollbackException | NotSupportedException | RollbackException | SystemException exc) {
            throw new ServletException(exc);
        }

        int robotId = getItemId(request, "robotId");
        int miningAreaId = getItemId(request, "miningAreaId");
        String submitType = request.getParameter("submitType");
        String[] selectedQueueItems = request.getParameterValues("selectedQueueItemId");
        
        if (submitType != null) {
            switch (submitType) {
                case "add":
                    addMiningQueueItem(userId, robotId, miningAreaId);
                    break;
                    
                case "remove":
                    if (selectedQueueItems != null) {
                        removeMiningQueueItems(userId, selectedQueueItems);
                    }
                    break;
            }
        }
        
        // Add the user item
        Users user = usersFacade.findById(userId);
        request.setAttribute("user", user);
        
        // Add the list of mining queue items
        List<MiningQueueItem> miningQueueList = getQueueInfo(miningQueueFacade.findWaitingByUsersId(userId), selectedQueueItems);
        request.setAttribute("miningQueueList", miningQueueList);
        
        // Add the map of queue sizes
        Map<Integer, Integer> miningQueueSizes = getQueueSizes(miningQueueList);
        request.setAttribute("miningQueueSizes", miningQueueSizes);
        
        // Add the list of robots
        List<Robot> robotList = robotFacade.findByUsersId(userId);
        request.setAttribute("robotList", robotList);
        
        // Add the list of mining areas
        List<MiningArea> miningAreaList = miningAreaFacade.findAll();
        request.setAttribute("miningAreaList", miningAreaList);
        
        // Select first ones from the lists when none selected yet
        if (miningAreaId <= 0 && !miningAreaList.isEmpty()) {
            miningAreaId = miningAreaList.get(0).getId();
        }
        
        if (robotId <= 0 && !robotList.isEmpty()) {
            robotId = robotList.get(0).getId();
        }
        
        // Add the previous selected ids
        request.setAttribute("robotId", robotId);
        request.setAttribute("miningAreaId", miningAreaId);
        
        request.getRequestDispatcher("/WEB-INF/view/miningqueue.jsp").forward(request, response);
    }

    private void addMiningQueueItem(int userId, int robotId, int miningAreaId) throws ServletException {
        
        List<MiningQueue> robotMiningQueueList = miningQueueFacade.findWaitingByRobotId(robotId);
        Robot robot = robotFacade.find(robotId);

        if (robot.getUser().getId() != userId) {
            robot = null;
        }
        
        MiningArea miningArea = miningAreaFacade.find(miningAreaId);
        
        if (robot != null && miningArea != null && robotMiningQueueList.size() < 10) {
            
            try {
                
                if (userAssets.payMiningCosts(userId, miningArea)) {

                    MiningQueue miningQueue = new MiningQueue();
                    miningQueue.setMiningArea(miningArea);
                    miningQueue.setRobot(robot);

                    miningQueueFacade.create(miningQueue);
                }
            }
            catch (IllegalStateException | SecurityException | HeuristicMixedException | HeuristicRollbackException | NotSupportedException | RollbackException | SystemException exc) {
                throw new ServletException(exc);
            }
        }
    }
    
    private void removeMiningQueueItems(int userId, String[] selectedQueueItems) {
        List<MiningQueueItem> miningQueueList = getQueueInfo(miningQueueFacade.findWaitingByUsersId(userId), selectedQueueItems);
        
        for (MiningQueueItem item : miningQueueList) {
            if (item.isSelected() && item.getItemStatus() == EMiningQueueItemStatus.QUEUED) {
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
