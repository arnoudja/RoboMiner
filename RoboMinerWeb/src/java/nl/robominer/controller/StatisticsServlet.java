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
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nl.robominer.businessentity.RobotStatistics;
import nl.robominer.entity.MiningOreResult;
import nl.robominer.entity.MiningQueue;
import nl.robominer.entity.Robot;
import nl.robominer.entity.RobotDailyResult;
import nl.robominer.entity.RobotDailyRuns;
import nl.robominer.session.MiningQueueFacade;
import nl.robominer.session.RobotDailyResultFacade;
import nl.robominer.session.RobotDailyRunsFacade;
import nl.robominer.session.RobotFacade;
import nl.robominer.session.UsersFacade;

/**
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "StatisticsServlet", urlPatterns = {"/statistics"})
public class StatisticsServlet extends RoboMinerServletBase {

    private static final int LAST_RESULT_COUNT = 100;

    @EJB
    private RobotFacade robotFacade;

    @EJB
    private MiningQueueFacade miningQueueFacade;

    @EJB
    private RobotDailyRunsFacade robotDailyRunsFacade;

    @EJB
    private RobotDailyResultFacade robotDailyResultFacade;

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

        int userId = (int) request.getSession().getAttribute("userId");

        processAssets(request);

        // Add the list of robots
        List<Robot> robotList = robotFacade.findByUsersId(userId);
        request.setAttribute("robotList", robotList);

        // Calculate the last results totals
        addLastResultsTotals(request, robotList);

        // Add the results for today
        Date now = new Date();
        addDayRangeTotals(request, robotList, now, now, "robotTodayStatisticsMap");

        // Add the results for yesterday
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(now);
        calendar.add(Calendar.DATE, -1);
        Date yesterday = new Date(calendar.getTimeInMillis());
        addDayRangeTotals(request, robotList, yesterday, yesterday, "robotYesterdayStatisticsMap");

        // Add the results of last 7 days
        calendar.setTime(yesterday);
        calendar.add(Calendar.DATE, -6);
        Date lastWeek = new Date(calendar.getTimeInMillis());
        addDayRangeTotals(request, robotList, lastWeek, yesterday, "robotLastWeekStatisticsMap");

        request.setAttribute("user", usersFacade.findById(getUserId(request)));

        request.getRequestDispatcher("/WEB-INF/view/statistics.jsp").forward(request, response);
    }

    private void addLastResultsTotals(HttpServletRequest request, List<Robot> robotList) {

        Map<Integer, RobotStatistics> robotStatisticsMap = new HashMap<>();

        for (Robot robot : robotList) {

            List<MiningQueue> robotResults = miningQueueFacade.findResultsByRobotId(robot.getId(), LAST_RESULT_COUNT);

            RobotStatistics robotStatistics = new RobotStatistics();

            robotStatistics.setRuns(robotResults.size());

            for (MiningQueue miningQueue : robotResults) {

                List<MiningOreResult> miningOreResultList = miningQueue.getMiningOreResults();

                for (MiningOreResult miningOreResult : miningOreResultList) {

                    robotStatistics.addOre(miningOreResult.getOre(), miningOreResult.getAmount(), miningOreResult.getTax());
                }
            }
            
            robotStatisticsMap.put(robot.getId(), robotStatistics);
        }
        request.setAttribute("robotLastRunsStatisticsMap", robotStatisticsMap);
    }

    private void addDayRangeTotals(HttpServletRequest request, List<Robot> robotList, Date firstDay, Date lastDay, String attributeName) {

        Map<Integer, RobotStatistics> robotStatisticsMap = new HashMap<>();

        for (Robot robot : robotList) {

            List<RobotDailyRuns> robotDailyRunsList = robotDailyRunsFacade.findByRobotIdAndMiningDayRange(robot.getId(), firstDay, lastDay);

            int totalRuns = 0;
            for (RobotDailyRuns robotDailyRuns : robotDailyRunsList) {
                totalRuns += robotDailyRuns.getTotalMiningRuns();
            }

            RobotStatistics robotStatistics = new RobotStatistics();

            robotStatistics.setRuns(totalRuns);

            List<RobotDailyResult> robotDailyResultList = robotDailyResultFacade.findByRobotIdAndMiningDayRange(robot.getId(), firstDay, lastDay);

            for (RobotDailyResult robotDailyResult : robotDailyResultList) {

                robotStatistics.addOre(robotDailyResult.getOre(), robotDailyResult.getAmount(), robotDailyResult.getTax());
            }

            robotStatisticsMap.put(robot.getId(), robotStatistics);
        }

        request.setAttribute(attributeName, robotStatisticsMap);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet for showing statistics information on robots and players";
    }

}
