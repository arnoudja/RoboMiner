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
import java.util.Objects;
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
import nl.robominer.entity.MiningArea;
import nl.robominer.entity.MiningAreaLifetimeResult;
import nl.robominer.entity.MiningOreResult;
import nl.robominer.entity.MiningQueue;
import nl.robominer.entity.Ore;
import nl.robominer.entity.OrePrice;
import nl.robominer.entity.OrePriceAmount;
import nl.robominer.entity.PendingRobotChanges;
import nl.robominer.entity.Robot;
import nl.robominer.entity.RobotLifetimeResult;
import nl.robominer.entity.RobotPart;
import nl.robominer.entity.UserOreAsset;
import nl.robominer.entity.UserRobotPartAsset;
import nl.robominer.entity.Users;
import nl.robominer.session.AchievementFacade;
import nl.robominer.session.MiningAreaLifetimeResultFacade;
import nl.robominer.session.MiningOreResultFacade;
import nl.robominer.session.MiningQueueFacade;
import nl.robominer.session.PendingRobotChangesFacade;
import nl.robominer.session.RobotFacade;
import nl.robominer.session.RobotLifetimeResultFacade;
import nl.robominer.session.RobotPartFacade;
import nl.robominer.session.UserOreAssetFacade;
import nl.robominer.session.UserRobotPartAssetFacade;
import nl.robominer.session.UsersFacade;

/**
 * Bean to handle the user-assets transactions.
 *
 * @author Arnoud Jagerman
 */
@Stateless
@TransactionManagement(TransactionManagementType.BEAN)
public class UserAssets
{
    /**
     * Database transactions resource.
     */
    @Resource
    UserTransaction transaction;

    /**
     * Bean to handle the database actions for the mining queue elements.
     */
    @EJB
    private MiningQueueFacade miningQueueFacade;

    /**
     * Bean to handle the database actions for the mining ore results.
     */
    @EJB
    private MiningOreResultFacade miningOreResultFacade;

    /**
     * Bean to handle the database actions for the mining area mining totals.
     */
    @EJB
    private MiningAreaLifetimeResultFacade miningAreaLifetimeResultFacade;

    /**
     * Bean to handle the database actions for the robots.
     */
    @EJB
    private RobotFacade robotFacade;

    /**
     * Bean to handle the database actions for the robot mining totals.
     */
    @EJB
    private RobotLifetimeResultFacade robotLifetimeResultFacade;

    /**
     * Bean to handle the database actions for the user ore assets.
     */
    @EJB
    private UserOreAssetFacade userOreAssetFacade;

    /**
     * Bean to handle the database actions for the robot parts.
     */
    @EJB
    private RobotPartFacade robotPartFacade;

    /**
     * Bean to handle the database actions for the user data.
     */
    @EJB
    private UsersFacade usersFacade;

    /**
     * Bean to handle the database actions for the user robot part assets.
     */
    @EJB
    private UserRobotPartAssetFacade userRobotPartAssetFacade;

    /**
     * Bean to handle the database actions for the achievements.
     */
    @EJB
    private AchievementFacade achievementFacade;

    /**
     * Bean to handle the database actions for pending robot changes.
     */
    @EJB
    private PendingRobotChangesFacade pendingRobotChangesFacade;

    /**
     * Process all claimable mining results for the specified user.
     *
     * @param userId The id of the user to process the claimable mining results
     *               for.
     *
     * @throws NotSupportedException      When a problem occurs with the
     *                                    database transaction.
     * @throws SystemException            When a problem occurs with the
     *                                    database transaction.
     * @throws IllegalStateException      When a problem occurs with the
     *                                    database transaction.
     * @throws HeuristicMixedException    When a problem occurs with the
     *                                    database transaction.
     * @throws RollbackException          When a problem occurs with the
     *                                    database transaction.
     * @throws SecurityException          When a problem occurs with the
     *                                    database transaction.
     * @throws HeuristicRollbackException When a problem occurs with the
     *                                    database transaction.
     */
    public void updateUserAssets(int userId) throws NotSupportedException,
                                                    SystemException,
                                                    IllegalStateException,
                                                    HeuristicMixedException,
                                                    RollbackException,
                                                    SecurityException,
                                                    HeuristicRollbackException
    {
        transaction.begin();

        List<MiningQueue> claimableMiningQueues = miningQueueFacade
                .findClaimableByUsersId(userId);

        for (MiningQueue miningQueue : claimableMiningQueues)
        {
            int robotId = miningQueue.getRobot().getId();

            Robot robot = robotFacade.findByIdAndUser(robotId, userId);
            robot.increateTotalMiningRuns();
            robotFacade.edit(robot);

            List<MiningOreResult> miningOreResultList = miningQueue
                    .getMiningOreResults();

            miningQueue.setClaimed(true);
            miningQueueFacade.edit(miningQueue);

            for (MiningOreResult miningOreResult : miningOreResultList)
            {
                miningOreResult.calculateTax();
                miningOreResultFacade.edit(miningOreResult);

                int oreId  = miningOreResult.getOre().getId();
                int amount = miningOreResult.getAmount();
                int tax    = miningOreResult.getTax();
                int reward = miningOreResult.getReward();

                updateRobotLifetimeResults(robotId, oreId, amount, tax);

                updateUserOreAssets(userId, oreId, reward);
            }

            updateMiningAreaLifetimeResults(miningQueue.getMiningArea(),
                                            miningOreResultList,
                                            robot.getMaxOre());
        }

        Users user = usersFacade.findById(userId);

        for (Robot robot : user.getRobotList())
        {
            PendingRobotChanges pendingRobotChanges = pendingRobotChangesFacade.findCommittedByRobotId(robot.getId());

            if (pendingRobotChanges != null)
            {
                if (!Objects.equals(pendingRobotChanges.getOldOreContainerId(),
                                    pendingRobotChanges.getOreContainer().getId()))
                {
                    user.getUserRobotPartAsset(pendingRobotChanges.getOldOreContainerId()).unassignOne();
                }

                if (!Objects.equals(pendingRobotChanges.getOldMiningUnitId(),
                                    pendingRobotChanges.getMiningUnit().getId()))
                {
                    user.getUserRobotPartAsset(pendingRobotChanges.getOldMiningUnitId()).unassignOne();
                }

                if (!Objects.equals(pendingRobotChanges.getOldBatteryId(),
                                    pendingRobotChanges.getBattery().getId()))
                {
                    user.getUserRobotPartAsset(pendingRobotChanges.getOldBatteryId()).unassignOne();
                }

                if (!Objects.equals(pendingRobotChanges.getOldMemoryModuleId(),
                                    pendingRobotChanges.getMemoryModule().getId()))
                {
                    user.getUserRobotPartAsset(pendingRobotChanges.getOldMemoryModuleId()).unassignOne();
                }

                if (!Objects.equals(pendingRobotChanges.getOldCpuId(),
                                    pendingRobotChanges.getCpu().getId()))
                {
                    user.getUserRobotPartAsset(pendingRobotChanges.getOldCpuId()).unassignOne();
                }

                if (!Objects.equals(pendingRobotChanges.getOldEngineId(),
                                    pendingRobotChanges.getEngine().getId()))
                {
                    user.getUserRobotPartAsset(pendingRobotChanges.getOldEngineId()).unassignOne();
                }

                usersFacade.edit(user);
                pendingRobotChangesFacade.remove(pendingRobotChanges);
            }
        }

        transaction.commit();
    }

    /**
     * If possible, subtract the mining costs for the specified mining area from
     * the user assets of the specified user and return true. If not possible,
     * return false.
     *
     * @param userId     The user to subtract the mining costs for.
     * @param miningArea The mining area to subtract the mining costs for.
     *
     * @return true if the mining costs are subtracted successfully, false if
     *         the assets of the user aren't sufficient.
     *
     * @throws NotSupportedException      When an unexpected database
     *                                    transaction problem occurred.
     * @throws SystemException            When an unexpected database
     *                                    transaction problem occurred.
     * @throws IllegalStateException      When an unexpected database
     *                                    transaction problem occurred.
     * @throws HeuristicMixedException    When an unexpected database
     *                                    transaction problem occurred.
     * @throws RollbackException          When an unexpected database
     *                                    transaction problem occurred.
     * @throws SecurityException          When an unexpected database
     *                                    transaction problem occurred.
     * @throws HeuristicRollbackException When an unexpected database
     *                                    transaction problem occurred.
     */
    public boolean payMiningCosts(int userId, MiningArea miningArea)
            throws NotSupportedException, SystemException, IllegalStateException,
                   HeuristicMixedException, RollbackException, SecurityException,
                   HeuristicRollbackException
    {
        boolean succeeded = false;

        transaction.begin();

        if (miningArea != null && payOreCosts(userId, miningArea.getOrePrice()))
        {
            succeeded = true;
            transaction.commit();
        }
        else
        {
            transaction.rollback();
        }

        return succeeded;
    }

    /**
     * If possible, subtract the costs of a robot part from the user assets, add
     * the robot part to the user assets and return true. If the user doesn't
     * have sufficient assets to pay for the transaction, return false.
     *
     * @param userId      The id of the user to buy the robot part for.
     * @param robotPartId The id of the robot part to buy.
     *
     * @return true if successful, false if the user doesn't have enough assets.
     *
     * @throws NotSupportedException      When an unexpected database
     *                                    transaction problem occurred.
     * @throws SystemException            When an unexpected database
     *                                    transaction problem occurred.
     * @throws RollbackException          When an unexpected database
     *                                    transaction problem occurred.
     * @throws HeuristicMixedException    When an unexpected database
     *                                    transaction problem occurred.
     * @throws HeuristicRollbackException When an unexpected database
     *                                    transaction problem occurred.
     */
    public boolean buyRobotPart(int userId, int robotPartId)
            throws NotSupportedException, SystemException, RollbackException,
                   HeuristicMixedException, HeuristicRollbackException
    {
        boolean succeeded = false;

        transaction.begin();

        RobotPart robotPart = robotPartFacade.find(robotPartId);

        if (robotPart != null && payOreCosts(userId, robotPart.getOrePrice()))
        {
            addRobotPart(userId, robotPartId, false);

            succeeded = true;
        }

        if (succeeded)
        {
            transaction.commit();
        }
        else
        {
            transaction.rollback();
        }

        return succeeded;
    }

    /**
     * For the specified user, if possible, subtract the price of the specified
     * robot part from the assets, add the robot part to the assets and return
     * true. When the user doesn't have sufficient assets for the transaction,
     * return false.
     *
     * @param userId      The id of the user to buy the robot part for.
     * @param robotPartId The id of the robot part to buy.
     *
     * @return true when successful, false when the user doesn't have enough
     *         assets.
     *
     * @throws NotSupportedException      NotSupportedException When an
     *                                    unexpected database transaction
     *                                    problem occurred.
     * @throws SystemException            NotSupportedException When an
     *                                    unexpected database transaction
     *                                    problem occurred.
     * @throws RollbackException          NotSupportedException When an
     *                                    unexpected database transaction
     *                                    problem occurred.
     * @throws HeuristicMixedException    NotSupportedException When an
     *                                    unexpected database transaction
     *                                    problem occurred.
     * @throws HeuristicRollbackException NotSupportedException When an
     *                                    unexpected database transaction
     *                                    problem occurred.
     */
    public boolean sellRobotPart(int userId, int robotPartId)
            throws NotSupportedException, SystemException, RollbackException,
                   HeuristicMixedException, HeuristicRollbackException
    {
        boolean succeeded = false;

        transaction.begin();

        RobotPart robotPart = robotPartFacade.find(robotPartId);
        UserRobotPartAsset userRobotPartAsset = userRobotPartAssetFacade
                .findByUsersIdAndRobotPartId(userId, robotPartId);

        if (robotPart != null && userRobotPartAsset != null &&
                userRobotPartAsset.getUnassigned() > 0)
        {
            if (userRobotPartAsset.getTotalOwned() > 1)
            {
                userRobotPartAsset.removeOneOwned();
                userRobotPartAssetFacade.edit(userRobotPartAsset);
            }
            else
            {
                userRobotPartAssetFacade.remove(userRobotPartAsset);
            }

            returnHalfOre(userId, robotPart.getOrePrice());

            succeeded = true;
        }

        if (succeeded)
        {
            transaction.commit();
        }
        else
        {
            transaction.rollback();
        }

        return succeeded;
    }

    /**
     * Create a new user, or specify the reason why this is not possible.
     *
     * @param newuser The Users instance to add, with its username, email and
     *                password already set.
     *
     * @return The status of the create user attempt.
     *
     * @throws NotSupportedException      NotSupportedException When an
     *                                    unexpected database transaction
     *                                    problem occurred.
     * @throws SystemException            NotSupportedException When an
     *                                    unexpected database transaction
     *                                    problem occurred.
     * @throws RollbackException          NotSupportedException When an
     *                                    unexpected database transaction
     *                                    problem occurred.
     * @throws HeuristicMixedException    NotSupportedException When an
     *                                    unexpected database transaction
     *                                    problem occurred.
     * @throws HeuristicRollbackException NotSupportedException When an
     *                                    unexpected database transaction
     *                                    problem occurred.
     */
    public UsersFacade.EWriteResult createNewUser(Users newuser)
            throws NotSupportedException, SystemException, RollbackException,
                   HeuristicMixedException, HeuristicRollbackException
    {
        newuser.fillDefaults();

        transaction.begin();

        UsersFacade.EWriteResult result = usersFacade.createNew(newuser);

        if (result != UsersFacade.EWriteResult.eSuccess)
        {
            transaction.rollback();
        }
        else
        {
            newuser.addUserAchievementIfApplicable(achievementFacade.findById(1));
            newuser.getUserAchievement(1).claimNextStep();

            usersFacade.edit(newuser);

            transaction.commit();
        }

        return result;
    }

    /**
     * Add a robot part to the user assets.
     *
     * @param usersId     The id of the user to add the robot part to.
     * @param robotPartId The id of the robot part to add.
     * @param assigned    When true, the robot part is added as assigned to a
     *                    robot, when false it is added as unassigned.
     */
    private void addRobotPart(int usersId, int robotPartId, boolean assigned)
    {
        UserRobotPartAsset userRobotPartAsset = userRobotPartAssetFacade
                .findByUsersIdAndRobotPartId(usersId, robotPartId);

        if (userRobotPartAsset == null)
        {
            userRobotPartAsset = new UserRobotPartAsset(usersId, robotPartId, 1,
                                                        assigned ? 0 : 1);
            userRobotPartAssetFacade.create(userRobotPartAsset);
        }
        else
        {
            userRobotPartAsset.addOneOwned(assigned);
            userRobotPartAssetFacade.edit(userRobotPartAsset);
        }
    }

    /**
     * If possible, subtract the specified ore amount from the assets of the
     * specified user and return true. When the assets of the specified user
     * aren't sufficient, return false.
     *
     * @param userId   The user to subtract the assets for.
     * @param orePrice The amounts of ore to subtract.
     *
     * @return true when successful, false when the user doesn't have enough
     *         assets.
     */
    private boolean payOreCosts(int userId, OrePrice orePrice)
    {
        boolean succeeded = true;

        List<OrePriceAmount> priceList = orePrice.getOrePriceAmountList();

        for (OrePriceAmount orePriceAmount : priceList)
        {
            UserOreAsset userOreAsset = userOreAssetFacade.findByUserAndOreId(
                    userId, orePriceAmount.getOre().getId());

            if (succeeded && userOreAsset != null &&
                userOreAsset.getAmount() >= orePriceAmount.getAmount())
            {
                userOreAsset.decreaseAmount(orePriceAmount.getAmount());
                userOreAssetFacade.edit(userOreAsset);
            }
            else
            {
                succeeded = false;
            }
        }

        return succeeded;
    }

    /**
     * Add half the ore price to the user assets of the specified user. Used
     * when a user sells a robot-part back to the system.
     *
     * @param userId   The id of the user to add the assets for.
     * @param orePrice The original price of the item.
     */
    private void returnHalfOre(int userId, OrePrice orePrice)
    {
        List<OrePriceAmount> priceList = orePrice.getOrePriceAmountList();

        for (OrePriceAmount orePriceAmount : priceList)
        {
            UserOreAsset userOreAsset = userOreAssetFacade.findByUserAndOreId(
                    userId, orePriceAmount.getOre().getId());

            if (userOreAsset == null)
            {
                userOreAsset = new UserOreAsset(userId,
                                                orePriceAmount.getOre().getId());
                userOreAsset.setAmount(orePriceAmount.getAmount() / 2);

                userOreAssetFacade.create(userOreAsset);
            }
            else
            {
                userOreAsset.increaseAmount(orePriceAmount.getAmount() / 2);
                userOreAssetFacade.edit(userOreAsset);
            }
        }
    }

    /**
     * Update the mining totals for the specified robot.
     *
     * @param robotId The id of the robot to update the mining totals for.
     * @param oreId   The ore id mined.
     * @param amount  The amount of ore mined for the specified ore.
     * @param tax     The amount of ore payed as tax for the specified ore.
     */
    private void updateRobotLifetimeResults(int robotId, int oreId, int amount,
                                            int tax)
    {
        RobotLifetimeResult robotLifetimeResult = robotLifetimeResultFacade
                .findByRobotAndOreId(robotId, oreId);

        if (robotLifetimeResult == null)
        {
            robotLifetimeResult = new RobotLifetimeResult(robotId, oreId, amount,
                                                          tax);
            robotLifetimeResultFacade.create(robotLifetimeResult);
        }
        else
        {
            robotLifetimeResult.increaseAmount(amount);
            robotLifetimeResult.increaseTax(tax);
            robotLifetimeResultFacade.edit(robotLifetimeResult);
        }
    }

    /**
     * Update the mining totals for the specified mining area.
     *
     * @param miningArea          The mining area to update the totals for.
     * @param miningOreResultList The list of ore mined.
     * @param containerSize       The size of the container of the robot
     *                            responsible for the mining.
     */
    private void updateMiningAreaLifetimeResults(MiningArea miningArea,
                                                 List<MiningOreResult> miningOreResultList,
                                                 int containerSize)
    {
        List<Ore> oreList = miningArea.getMiningAreaOreTypes();

        for (Ore ore : oreList)
        {
            int amount = 0;

            for (MiningOreResult miningOreResult : miningOreResultList)
            {
                if (Objects.equals(miningOreResult.getOre().getId(), ore.getId()))
                {
                    amount = miningOreResult.getAmount();
                }
            }

            MiningAreaLifetimeResult miningAreaLifetimeResult = miningAreaLifetimeResultFacade
                    .findByPK(miningArea.getId(), ore.getId());

            if (miningAreaLifetimeResult == null)
            {
                miningAreaLifetimeResult = new MiningAreaLifetimeResult(
                        miningArea.getId(), ore.getId(), amount, containerSize);
                miningAreaLifetimeResultFacade.create(miningAreaLifetimeResult);
            }
            else
            {
                miningAreaLifetimeResult.increaseTotalAmount(amount);
                miningAreaLifetimeResult.increaseTotalContainerSize(containerSize);
                miningAreaLifetimeResultFacade.edit(miningAreaLifetimeResult);
            }
        }
    }

    /**
     * Add the specified amount of ore of the specified type to the user-assets
     * of the specified user.
     *
     * @param userId The user to add the ore assets for.
     * @param oreId  The ore type to add.
     * @param reward The amount of ore to add.
     */
    private void updateUserOreAssets(int userId, int oreId, int reward)
    {
        UserOreAsset userOreAsset = userOreAssetFacade.findByUserAndOreId(userId, oreId);

        if (userOreAsset == null)
        {
            userOreAsset = new UserOreAsset(userId, oreId);
            userOreAsset.setAmount(reward);

            userOreAssetFacade.create(userOreAsset);
        }
        else
        {
            userOreAsset.increaseAmount(reward);
            userOreAssetFacade.edit(userOreAsset);
        }
    }
}
