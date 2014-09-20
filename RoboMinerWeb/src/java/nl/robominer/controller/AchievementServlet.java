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
import java.util.HashMap;
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
import nl.robominer.businessentity.UserAssets;
import nl.robominer.entity.AchievementMiningTotalRequirement;
import nl.robominer.entity.Robot;
import nl.robominer.entity.RobotLifetimeResult;
import nl.robominer.entity.UserAchievement;
import nl.robominer.session.RobotFacade;
import nl.robominer.session.UserAchievementFacade;
import nl.robominer.session.UsersFacade;

/**
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "AchievementServlet", urlPatterns = {"/achievements"})
public class AchievementServlet extends RoboMinerServletBase {

    @EJB
    private UserAchievementFacade userAchievementFacade;

    @EJB
    private RobotFacade robotFacade;

    @EJB
    private UserAssets userAssets;

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

        int usersId = (int) request.getSession().getAttribute("userId");

        int achievementId = getItemId(request, "achievementId");
        if (achievementId > 0) {
            claimAchievement(usersId, achievementId);
        }

        // Add the user data
        request.setAttribute("user", usersFacade.findById(usersId));

        // Add the list of achievements to display
        List<UserAchievement> userAchievementList = userAchievementFacade.findUnclaimedByUsersId(usersId);
        request.setAttribute("userAchievementList", userAchievementList);

        // Add the amounts of ore mined
        request.setAttribute("totalOreMined", getTotalOreMined(usersId));

        request.getRequestDispatcher("/WEB-INF/view/achievements.jsp").forward(request, response);
    }

    private Map<Integer, Long> getTotalOreMined(int userId) {
        
        Map<Integer, Long> result = new HashMap<>();
        
        List<Robot> robotList = robotFacade.findByUsersId(userId);
        
        for (Robot robot : robotList) {
            
            List<RobotLifetimeResult> robotLifetimeResultList = robot.getRobotLifetimeResultList();
            
            for (RobotLifetimeResult robotLifetimeResult : robotLifetimeResultList) {
                
                int oreId = robotLifetimeResult.getRobotLifetimeResultPK().getOreId();
                Long oldResult = result.get(oreId);
                
                Long newResult;
                if (oldResult == null) {
                    newResult = (long)robotLifetimeResult.getAmount();
                }
                else {
                    newResult = oldResult + robotLifetimeResult.getAmount();
                }

                result.put(robotLifetimeResult.getRobotLifetimeResultPK().getOreId(), newResult);
            }
        }

        return result;
    }

    private void claimAchievement(int usersId, int achievementId) throws ServletException {

        UserAchievement userAchievement = userAchievementFacade.findByUsersAndAchievementId(usersId, achievementId);

        if (userAchievement != null && !userAchievement.getClaimed()) {

            boolean claimable = true;
            Map<Integer, Long> totalOreMined = getTotalOreMined(usersId);

            List<AchievementMiningTotalRequirement> achievementMiningTotalRequirementList = userAchievement.getAchievement().getAchievementMiningTotalRequirementList();

            for (AchievementMiningTotalRequirement achievementMiningTotalRequirement : achievementMiningTotalRequirementList) {

                Long oreMined = totalOreMined.get(achievementMiningTotalRequirement.getAchievementMiningTotalRequirementPK().getOreId());
                if (oreMined == null || oreMined < achievementMiningTotalRequirement.getAmount()) {
                    claimable = false;
                }
            }

            if (claimable) {
                try {
                    userAssets.claimAchievement(usersId, achievementId);
                }
                catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException ex) {
                    throw new ServletException(ex);
                }
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Achievements display servlet";
    }

}
