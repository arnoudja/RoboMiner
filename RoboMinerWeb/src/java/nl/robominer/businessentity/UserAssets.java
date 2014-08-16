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
import nl.robominer.entity.MiningArea;
import nl.robominer.entity.MiningOreResult;
import nl.robominer.entity.MiningQueue;
import nl.robominer.entity.OrePrice;
import nl.robominer.entity.OrePriceAmount;
import nl.robominer.entity.RobotPart;
import nl.robominer.entity.UserOreAsset;
import nl.robominer.entity.UserRobotPartAsset;
import nl.robominer.session.MiningQueueFacade;
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
    private UserOreAssetFacade userOreAssetFacade;
    
    @EJB
    private RobotPartFacade robotPartFacade;
    
    @EJB
    private UserRobotPartAssetFacade userRobotPartAssetFacade;
    
    public void updateUserAssets(int userId) throws NotSupportedException, SystemException, IllegalStateException, HeuristicMixedException, RollbackException, SecurityException, HeuristicRollbackException {
        
        transaction.begin();

        List<MiningQueue> claimableMiningQueues = miningQueueFacade.findClaimableByUsersId(userId);

        for (MiningQueue miningQueue : claimableMiningQueues) {

            List<MiningOreResult> miningOreResultList = miningQueue.getMiningOreResults();

            miningQueue.setClaimed(true);
            miningQueueFacade.edit(miningQueue);

            for (MiningOreResult miningOreResult : miningOreResultList) {

                int oreId = miningOreResult.getOre().getId();
                int reward = miningOreResult.getReward();

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
        }

        transaction.commit();
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
            
            UserRobotPartAsset userRobotPartAsset = userRobotPartAssetFacade.findByUsersIdAndRobotPartId(userId, robotPartId);
            
            if (userRobotPartAsset == null) {
                
                userRobotPartAsset = new UserRobotPartAsset(userId, robotPartId, 1);
                userRobotPartAssetFacade.create(userRobotPartAsset);
            }
            else {
                
                userRobotPartAsset.addOne();
                userRobotPartAssetFacade.edit(userRobotPartAsset);
            }
            
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
}
