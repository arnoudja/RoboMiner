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
import nl.robominer.entity.ProgramSource;

/**
 *
 * @author Arnoud Jagerman
 */
@Stateless
public class ProgramSourceFacade extends AbstractFacade<ProgramSource> {

    @PersistenceContext(unitName = "RoboMinerWebPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ProgramSourceFacade() {
        super(ProgramSource.class);
    }

    public ProgramSource findByIdAndUser(int id, int usersId) {
        
        try {
            Query query = getEntityManager().createNamedQuery("ProgramSource.findByIdAndUser", ProgramSource.class);
            query.setParameter("id", id);
            query.setParameter("usersId", usersId);
            return (ProgramSource)query.getSingleResult();
        }
        catch (javax.persistence.NoResultException exc) {
            return null;
        }
    }

    public List<ProgramSource> findByUsersId(int usersId) {

        Query query = getEntityManager().createNamedQuery("ProgramSource.findByUsersId", ProgramSource.class);
        query.setParameter("usersId", usersId);
        
        return query.getResultList();
    }

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
