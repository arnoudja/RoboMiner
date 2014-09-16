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

import java.util.Date;
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
import nl.robominer.entity.Robot;
import nl.robominer.entity.RobotDailyResult;
import nl.robominer.entity.RobotDailyRuns;
import nl.robominer.entity.RobotLifetimeResult;
import nl.robominer.entity.RobotPart;
import nl.robominer.entity.UserOreAsset;
import nl.robominer.entity.UserRobotPartAsset;
import nl.robominer.session.MiningAreaLifetimeResultFacade;
import nl.robominer.session.MiningOreResultFacade;
import nl.robominer.session.MiningQueueFacade;
import nl.robominer.session.RobotDailyResultFacade;
import nl.robominer.session.RobotDailyRunsFacade;
import nl.robominer.session.RobotFacade;
import nl.robominer.session.RobotLifetimeResultFacade;
import nl.robominer.session.RobotPartFacade;
import nl.robominer.session.UserOreAssetFacade;
import nl.robominer.session.UserRobotPartAssetFacade;

/**
 *
 * @author Arnoud Jagerman
 */
@Stateless
@TransactionManagement( TransactionManagementType.BEAN )
public class UserAssets {

    @Resource
    UserTransaction transaction;
    
    @EJB
    private MiningQueueFacade miningQueueFacade;

    @EJB
    private MiningOreResultFacade miningOreResultFacade;

    @EJB
    private MiningAreaLifetimeResultFacade miningAreaLifetimeResultFacade;

    @EJB
    private RobotFacade robotFacade;

    @EJB
    private RobotLifetimeResultFacade robotLifetimeResultFacade;

    @EJB
    private RobotDailyRunsFacade robotDailyRunsFacade;

    @EJB
    private RobotDailyResultFacade robotDailyResultFacade;

    @EJB
    private UserOreAssetFacade userOreAssetFacade;

    @EJB
    private RobotPartFacade robotPartFacade;

    @EJB
    private UserRobotPartAssetFacade userRobotPartAssetFacade;

    public void updateUserAssets(int userId) throws NotSupportedException, SystemException, IllegalStateException, HeuristicMixedException, RollbackException, SecurityException, HeuristicRollbackException {

        transaction.begin();

        List<MiningQueue> claimableMiningQueues = miningQueueFacade.findClaimableByUsersId(userId);

        for (MiningQueue miningQueue : claimableMiningQueues) {

            int  robotId   = miningQueue.getRobot().getId();
            Date miningDay = miningQueue.getMiningEndTime();

            Robot robot = robotFacade.findByIdAndUser(robotId, userId);
            robot.increateTotalMiningRuns();
            robotFacade.edit(robot);

            updateRobotDailyRuns(robotId, miningQueue.getMiningEndTime());

            List<MiningOreResult> miningOreResultList = miningQueue.getMiningOreResults();

            miningQueue.setClaimed(true);
            miningQueueFacade.edit(miningQueue);

            for (MiningOreResult miningOreResult : miningOreResultList) {

                miningOreResult.calculateTax();
                miningOreResultFacade.edit(miningOreResult);

                int oreId  = miningOreResult.getOre().getId();
                int amount = miningOreResult.getAmount();
                int tax    = miningOreResult.getTax();
                int reward = miningOreResult.getReward();

                updateRobotLifetimeResults(robotId, oreId, amount, tax);
                updateRobotDailyResult(robotId, oreId, miningDay, amount, tax);

                updateUserOreAssets(userId, oreId, reward);
            }

            updateMiningAreaLifetimeResults(miningQueue.getMiningArea(), miningOreResultList, robot.getMaxOre());
        }

        transaction.commit();
    }

    private void updateRobotLifetimeResults(int robotId, int oreId, int amount, int tax) {

        RobotLifetimeResult robotLifetimeResult = robotLifetimeResultFacade.findByRobotAndOreId(robotId, oreId);

        if (robotLifetimeResult == null) {

            robotLifetimeResult = new RobotLifetimeResult(robotId, oreId, amount, tax);
            robotLifetimeResultFacade.create(robotLifetimeResult);
        }
        else {

            robotLifetimeResult.increaseAmount(amount);
            robotLifetimeResult.increaseTax(tax);
            robotLifetimeResultFacade.edit(robotLifetimeResult);
        }
    }

    private void updateMiningAreaLifetimeResults(MiningArea miningArea, List<MiningOreResult> miningOreResultList, int containerSize) {

        List<Ore> oreList = miningArea.getMiningAreaOreTypes();

        for (Ore ore : oreList) {

            int amount = 0;
            
            for (MiningOreResult miningOreResult : miningOreResultList) {
                
                if (Objects.equals(miningOreResult.getOre().getId(), ore.getId())) {
                    amount = miningOreResult.getAmount();
                }
            }

            MiningAreaLifetimeResult miningAreaLifetimeResult = miningAreaLifetimeResultFacade.findByPK(miningArea.getId(), ore.getId());

            if (miningAreaLifetimeResult == null) {

                miningAreaLifetimeResult = new MiningAreaLifetimeResult(miningArea.getId(), ore.getId(), amount, containerSize);
                miningAreaLifetimeResultFacade.create(miningAreaLifetimeResult);
            }
            else {

                miningAreaLifetimeResult.increaseTotalAmount(amount);
                miningAreaLifetimeResult.increaseTotalContainerSize(containerSize);
                miningAreaLifetimeResultFacade.edit(miningAreaLifetimeResult);
            }
        }
    }

    private void updateRobotDailyRuns(int robotId, Date miningDay) {

        RobotDailyRuns robotDailyRuns = robotDailyRunsFacade.findByRobotIdAndMiningDay(robotId, miningDay);

        if (robotDailyRuns == null) {

            robotDailyRuns = new RobotDailyRuns(robotId, miningDay, 1);
            robotDailyRunsFacade.create(robotDailyRuns);
        }
        else {

            robotDailyRuns.increaseTotalMiningRuns();
            robotDailyRunsFacade.edit(robotDailyRuns);
        }
    }

    private void updateRobotDailyResult(int robotId, int oreId, Date miningDay, int amount, int tax) {

        RobotDailyResult robotDailyResult = robotDailyResultFacade.findByPK(robotId, oreId, miningDay);

        if (robotDailyResult == null) {

            robotDailyResult = new RobotDailyResult(robotId, oreId, miningDay, amount, tax);
            robotDailyResultFacade.create(robotDailyResult);
        }
        else {

            robotDailyResult.increaseAmount(amount);
            robotDailyResult.increaseTax(tax);
            robotDailyResultFacade.edit(robotDailyResult);
        }
    }

    private void updateUserOreAssets(int userId, int oreId, int reward) {
        
        UserOreAsset userOreAsset = userOreAssetFacade.findByUserAndOreId(userId, oreId);

        if (userOreAsset == null) {

            userOreAsset = new UserOreAsset(userId, oreId);
            userOreAsset.setAmount(reward);

            userOreAssetFacade.create(userOreAsset);
        }
        else {

            userOreAsset.increaseAmount(reward);

            userOreAssetFacade.edit(userOreAsset);
        }
    }

    public boolean payMiningCosts(int userId, MiningArea miningArea) throws NotSupportedException, SystemException, IllegalStateException, HeuristicMixedException, RollbackException, SecurityException, HeuristicRollbackException {
        
        boolean succeeded = false;

        transaction.begin();

        if (miningArea != null && payOreCosts(userId, miningArea.getOrePrice())) {

            succeeded = true;
            transaction.commit();
        }
        else {
            transaction.rollback();
        }

        return succeeded;
    }

    public boolean buyRobotPart(int userId, int robotPartId) throws NotSupportedException, SystemException, RollbackException, HeuristicMixedException, HeuristicRollbackException {

        boolean succeeded = false;

        transaction.begin();

        RobotPart robotPart = robotPartFacade.find(robotPartId);

        if (robotPart != null && payOreCosts(userId, robotPart.getOrePrice())) {

            addRobotPart(userId, robotPartId, false);

            succeeded = true;
        }

        if (succeeded) {
            transaction.commit();
        }
        else {
            transaction.rollback();
        }
        
        return succeeded;
    }

    public void addRobotPart(int usersId, int robotPartId, boolean assigned) {

        UserRobotPartAsset userRobotPartAsset = userRobotPartAssetFacade.findByUsersIdAndRobotPartId(usersId, robotPartId);

        if (userRobotPartAsset == null) {

            userRobotPartAsset = new UserRobotPartAsset(usersId, robotPartId, 1, assigned ? 0 : 1);
            userRobotPartAssetFacade.create(userRobotPartAsset);
        }
        else {

            userRobotPartAsset.addOneOwned(assigned);
            userRobotPartAssetFacade.edit(userRobotPartAsset);
        }
    }

    public boolean sellRobotPart(int userId, int robotPartId) throws NotSupportedException, SystemException, RollbackException, HeuristicMixedException, HeuristicRollbackException {
        
        boolean succeeded = false;
        
        transaction.begin();

        RobotPart robotPart = robotPartFacade.find(robotPartId);
        UserRobotPartAsset userRobotPartAsset = userRobotPartAssetFacade.findByUsersIdAndRobotPartId(userId, robotPartId);
        
        if (robotPart != null && userRobotPartAsset != null && userRobotPartAsset.getUnassigned() > 0) {
            
            if (userRobotPartAsset.getTotalOwned() > 1) {
                
                userRobotPartAsset.removeOneOwned();
                userRobotPartAssetFacade.edit(userRobotPartAsset);
            }
            else {
                userRobotPartAssetFacade.remove(userRobotPartAsset);
            }
            
            returnHalfOre(userId, robotPart.getOrePrice());
            
            succeeded = true;
        }

        if (succeeded) {
            transaction.commit();
        }
        else {
            transaction.rollback();
        }
        
        return succeeded;
    }
    
    public boolean payOreCosts(int userId, OrePrice orePrice) {
        
        boolean succeeded = true;

        List<OrePriceAmount> priceList = orePrice.getOrePriceAmountList();
        
        for (OrePriceAmount orePriceAmount : priceList) {
            
            UserOreAsset userOreAsset = userOreAssetFacade.findByUserAndOreId(userId, orePriceAmount.getOre().getId());

            if (succeeded && userOreAsset != null && userOreAsset.getAmount() >= orePriceAmount.getAmount()) {

                userOreAsset.decreaseAmount(orePriceAmount.getAmount());
                userOreAssetFacade.edit(userOreAsset);
            }
            else {
                succeeded = false;
            }
        }

        return succeeded;
    }
    
    public void returnHalfOre(int userId, OrePrice orePrice) {
        
        List<OrePriceAmount> priceList = orePrice.getOrePriceAmountList();
        
        for (OrePriceAmount orePriceAmount : priceList) {
            
            UserOreAsset userOreAsset = userOreAssetFacade.findByUserAndOreId(userId, orePriceAmount.getOre().getId());
            
            if (userOreAsset == null) {
                
                userOreAsset = new UserOreAsset(userId, orePriceAmount.getOre().getId());
                userOreAsset.setAmount(orePriceAmount.getAmount() / 2);
                
                userOreAssetFacade.create(userOreAsset);
            }
            else {
                
                userOreAsset.increaseAmount(orePriceAmount.getAmount() / 2);
                userOreAssetFacade.edit(userOreAsset);
            }
        }
    }
}
