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
import nl.robominer.entity.MiningQueue;

/**
 *
 * @author Arnoud Jagerman
 */
@Stateless
public class MiningQueueFacade extends AbstractFacade<MiningQueue>
{
    @PersistenceContext(unitName = "RoboMinerWebPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager()
    {
        return em;
    }

    public MiningQueueFacade()
    {
        super(MiningQueue.class);
    }

    public List<MiningQueue> findWaitingByUsersId(int usersId)
    {
        Query query = getEntityManager().createNamedQuery("MiningQueue.findWaitingByUsersId", MiningQueue.class);
        query.setParameter("usersId", usersId);
        return query.getResultList();
    }

    public List<MiningQueue> findWaitingByRobotId(int robotId)
    {
        Query query = getEntityManager().createNamedQuery("MiningQueue.findWaitingByRobotId", MiningQueue.class);
        query.setParameter("robotId", robotId);
        return query.getResultList();
    }

    public List<MiningQueue> findResultsByRobotId(int robotId, int maxSize)
    {
        Query query = getEntityManager().createNamedQuery("MiningQueue.findResultsByRobotId", MiningQueue.class);
        query.setParameter("robotId", robotId);
        query.setMaxResults(maxSize);
        return query.getResultList();
    }

    public List<MiningQueue> findClaimableByUsersId(int usersId)
    {
        Query query = getEntityManager().createNamedQuery("MiningQueue.findClaimableByUsersId", MiningQueue.class);
        query.setParameter("usersId", usersId);
        return query.getResultList();
    }

    public MiningQueue findByRallyAndUsersId(int rallyResultId, int usersId)
    {
        try
        {
            Query query = getEntityManager().createNamedQuery("MiningQueue.findByRallyAndUsersId", MiningQueue.class);
            query.setParameter("rallyResultId", rallyResultId);
            query.setParameter("usersId", usersId);
            return (MiningQueue)query.getSingleResult();
        }
        catch (javax.persistence.NoResultException exc)
        {
            return null;
        }
    }

    public List<MiningQueue> findMostRecent(int maxSize)
    {
        Query query = getEntityManager().createNamedQuery("MiningQueue.findMostRecent", MiningQueue.class);
        query.setMaxResults(maxSize);
        return query.getResultList();
    }
}
