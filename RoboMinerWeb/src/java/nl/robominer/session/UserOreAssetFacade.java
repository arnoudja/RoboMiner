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
import nl.robominer.entity.UserOreAsset;

/**
 *
 * @author Arnoud Jagerman
 */
@Stateless
public class UserOreAssetFacade extends AbstractFacade<UserOreAsset> {
    @PersistenceContext(unitName = "RoboMinerWebPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UserOreAssetFacade() {
        super(UserOreAsset.class);
    }
    
    public UserOreAsset findByUserAndOreId(int usersId, int oreId) {
        try {
            Query query = getEntityManager().createNamedQuery("UserOreAsset.findByUserAndOreId", UserOreAsset.class);
            query.setParameter("usersId", usersId);
            query.setParameter("oreId", oreId);
            return (UserOreAsset)query.getSingleResult();
        }
        catch (javax.persistence.NoResultException exc) {
            return null;
        }
    }

    public List<UserOreAsset> findByUsersId(int usersId) {
        Query query = getEntityManager().createNamedQuery("UserOreAsset.findByUsersId", UserOreAsset.class);
        query.setParameter("usersId", usersId);
        return query.getResultList();
    }
    
}
