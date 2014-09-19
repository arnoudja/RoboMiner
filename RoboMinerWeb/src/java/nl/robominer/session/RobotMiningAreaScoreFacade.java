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
import nl.robominer.entity.RobotMiningAreaScore;

/**
 * A session bean to manage the database access for the RobotMiningAreaScore class.
 *
 * @author Arnoud Jagerman
 */
@Stateless
public class RobotMiningAreaScoreFacade extends AbstractFacade<RobotMiningAreaScore> {
    @PersistenceContext(unitName = "RoboMinerWebPU")
    private EntityManager em;

    /**
     * Retrieve the entity manager for this instance.
     *
     * @return The entity manager.
     */
    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    /**
     * Default constructor.
     */
    public RobotMiningAreaScoreFacade() {
        super(RobotMiningAreaScore.class);
    }

    /**
     * Retrieve a list of robot scores for the specified mining area, ordered by
     * descending score.
     *
     * @param miningAreaId The mining area to retrieve the scores for.
     * @param minimumRuns The minimum number of runs a robot must have made in
     *                    the mining area to return its result.
     * @param maximumResults The maximum number of results to return.
     * @return The ordered list of robot scores.
     */
    public List<RobotMiningAreaScore> findByMiningAreaId(int miningAreaId, int minimumRuns, int maximumResults) {
        Query query = getEntityManager().createNamedQuery("RobotMiningAreaScore.findByMiningAreaId", RobotMiningAreaScore.class);
        query.setParameter("miningAreaId", miningAreaId);
        query.setParameter("minimumRuns", minimumRuns);
        query.setMaxResults(maximumResults);
        return query.getResultList();
    }

}
