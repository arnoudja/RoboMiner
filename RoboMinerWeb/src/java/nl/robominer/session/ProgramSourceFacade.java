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

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import nl.robominer.entity.ProgramSource;

/**
 * Session bean for the ProgramSource entity class.
 *
 * @author Arnoud Jagerman
 */
@Stateless
public class ProgramSourceFacade extends AbstractFacade<ProgramSource> {

    /**
     * The EntityManager instance used for the database access.
     */
    @PersistenceContext(unitName = "RoboMinerWebPU")
    private EntityManager em;

    /**
     * Retrieve the EntityManager instance for this session bean.
     *
     * @return The EntityManager instance for this session bean.
     */
    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    /**
     * Default constructor.
     */
    public ProgramSourceFacade() {
        super(ProgramSource.class);
    }

    /**
     * Retrieve a suitable program for a robot.
     *
     * @param usersId The user owning the robot.
     * @param maxSize The robot memory size.
     *
     * @return A suitable program for the robot, or null if none found.
     */
    public ProgramSource findSuiteableByUsersId(int usersId, int maxSize) {

        try {
            Query query = getEntityManager().createNamedQuery("ProgramSource.findSuiteableByUsersId", ProgramSource.class);
            query.setParameter("usersId", usersId);
            query.setParameter("maxSize", maxSize);
            return (ProgramSource)query.getSingleResult();
        }
        catch (javax.persistence.NoResultException exc) {
            return null;
        }
    }

}
