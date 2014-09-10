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

import java.util.Date;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import nl.robominer.entity.RobotDailyRuns;

/**
 *
 * @author Arnoud Jagerman
 */
@Stateless
public class RobotDailyRunsFacade extends AbstractFacade<RobotDailyRuns> {

    @PersistenceContext(unitName = "RoboMinerWebPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public RobotDailyRunsFacade() {
        super(RobotDailyRuns.class);
    }

    public RobotDailyRuns findByRobotIdAndMiningDay(int robotId, Date miningDay) {
        try {
            Query query = getEntityManager().createNamedQuery("RobotDailyRuns.findByRobotIdAndMiningDay", RobotDailyRuns.class);
            query.setParameter("robotId", robotId);
            query.setParameter("miningDay", miningDay);
            return (RobotDailyRuns)query.getSingleResult();
        }
        catch (javax.persistence.NoResultException exc) {
            return null;
        }
    }

}