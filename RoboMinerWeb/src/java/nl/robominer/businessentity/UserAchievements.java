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

package nl.robominer.businessentity;

import java.util.List;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.transaction.HeuristicMixedException;
import javax.transaction.HeuristicRollbackException;
import javax.transaction.NotSupportedException;
import javax.transaction.RollbackException;
import javax.transaction.SystemException;
import javax.transaction.UserTransaction;
import nl.robominer.entity.Achievement;
import nl.robominer.entity.Robot;
import nl.robominer.entity.RobotPart;
import nl.robominer.entity.UserAchievement;
import nl.robominer.entity.Users;
import nl.robominer.session.RobotFacade;
import nl.robominer.session.RobotPartFacade;
import nl.robominer.session.UserAchievementFacade;
import nl.robominer.session.UsersFacade;

/**
 *
 * @author Arnoud Jagerman
 */
@Stateless
@TransactionManagement( TransactionManagementType.BEAN )
public class UserAchievements {

    @Resource
    UserTransaction transaction;

    @EJB UserAssets userAssets;

    @EJB
    private UsersFacade usersFacade;

    @EJB
    private RobotFacade robotFacade;

    @EJB
    private RobotPartFacade robotPartFacade;

    @EJB
    private UserAchievementFacade userAchievementFacade;

    public void claimAchievement(int usersId, int achievementId) throws NotSupportedException, SystemException, RollbackException, HeuristicMixedException, HeuristicRollbackException {

        transaction.begin();

        UserAchievement userAchievement = userAchievementFacade.findByUsersAndAchievementId(usersId, achievementId);

        if (userAchievement != null && !userAchievement.getClaimed()) {

            userAchievement.setClaimed(true);
            userAchievementFacade.edit(userAchievement);

            Users user = usersFacade.findById(usersId);
            Achievement achievement = userAchievement.getAchievement();

            user.increaseAchievementPoints(achievement.getAchievementPoints());
            user.increaseMiningQueueSize(achievement.getMiningQueueReward());

            if (achievement.getRobotReward() > 0) {
                addRobot(user);
            }

            usersFacade.edit(user);

            List<Achievement> achievementSuccessorList = achievement.getAchievementSuccessorList();

            for (Achievement successor : achievementSuccessorList) {

                UserAchievement successorUserAchievement = new UserAchievement(usersId, successor.getId());
                userAchievementFacade.create(successorUserAchievement);
            }
        }

        transaction.commit();
    }

    private void addRobot(Users user) {

        // Retrieve the initial robot parts
        RobotPart oreContainer  = robotPartFacade.find(101);
        RobotPart miningUnit    = robotPartFacade.find(201);
        RobotPart battery       = robotPartFacade.find(301);
        RobotPart memoryModule  = robotPartFacade.find(401);
        RobotPart cpu           = robotPartFacade.find(501);
        RobotPart engine        = robotPartFacade.find(601);

        // Add the initial robot parts for the user
        userAssets.addRobotPart(user.getId(), oreContainer.getId(), true);
        userAssets.addRobotPart(user.getId(), miningUnit.getId(), true);
        userAssets.addRobotPart(user.getId(), battery.getId(), true);
        userAssets.addRobotPart(user.getId(), memoryModule.getId(), true);
        userAssets.addRobotPart(user.getId(), cpu.getId(), true);
        userAssets.addRobotPart(user.getId(), engine.getId(), true);

        // Create a robot for the user
        Robot robot = new Robot();
        robot.fillDefaults(oreContainer, miningUnit, battery, memoryModule, cpu, engine);
        robot.setRobotName(user.getUsername() + "_" + (user.getRobots().size() + 1));
        robot.setUser(user);
        robot.setProgramSourceId(user.getProgramSourceList().get(0).getId());
        robotFacade.create(robot);
    }
}
