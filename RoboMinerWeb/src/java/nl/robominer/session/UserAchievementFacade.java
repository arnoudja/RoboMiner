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
import nl.robominer.entity.UserAchievement;

/**
 *
 * @author Arnoud Jagerman
 */
@Stateless
public class UserAchievementFacade extends AbstractFacade<UserAchievement> {

    @PersistenceContext(unitName = "RoboMinerWebPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UserAchievementFacade() {
        super(UserAchievement.class);
    }

    public List<UserAchievement> findUnclaimedByUsersId(int usersId) {
        Query query = getEntityManager().createNamedQuery("UserAchievement.findUnclaimedByUsersId", UserAchievement.class);
        query.setParameter("usersId", usersId);
        return query.getResultList();
    }

    public UserAchievement findByUsersAndAchievementId(int usersId, int achievementId) {
        try {
            Query query = getEntityManager().createNamedQuery("UserAchievement.findByUsersAndAchievementId", UserAchievement.class);
            query.setParameter("usersId", usersId);
            query.setParameter("achievementId", achievementId);
            return (UserAchievement)query.getSingleResult();
        }
        catch (javax.persistence.NoResultException exc) {
            return null;
        }
    }
}