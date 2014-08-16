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

package nl.robominer.session;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import nl.robominer.entity.UserRobotPartAsset;

/**
 *
 * @author Arnoud Jagerman
 */
@Stateless
public class UserRobotPartAssetFacade extends AbstractFacade<UserRobotPartAsset> {
    @PersistenceContext(unitName = "RoboMinerWebPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UserRobotPartAssetFacade() {
        super(UserRobotPartAsset.class);
    }
    
    public List<UserRobotPartAsset> findByUsersId(int usersId) {
        Query query = getEntityManager().createNamedQuery("UserRobotPartAsset.findByUsersId", UserRobotPartAsset.class);
        query.setParameter("usersId", usersId);
        return query.getResultList();
    }
    
    public List<UserRobotPartAsset> findByUsersIdAndPartType(int usersId, int robotPartTypeId) {
        Query query = getEntityManager().createNamedQuery("UserRobotPartAsset.findByUsersIdAndPartType", UserRobotPartAsset.class);
        query.setParameter("usersId", usersId);
        query.setParameter("robotPartTypeId", robotPartTypeId);
        return query.getResultList();
    }
    
    public UserRobotPartAsset findByUsersIdAndRobotPartId(int usersId, int robotPartId) {
        try {
            Query query = getEntityManager().createNamedQuery("UserRobotPartAsset.findByUsersIdAndRobotPartId", UserRobotPartAsset.class);
            query.setParameter("usersId", usersId);
            query.setParameter("robotPartId", robotPartId);
            return (UserRobotPartAsset)query.getSingleResult();
        }
        catch (javax.persistence.NoResultException exc) {
            return null;
        }
    }
}
