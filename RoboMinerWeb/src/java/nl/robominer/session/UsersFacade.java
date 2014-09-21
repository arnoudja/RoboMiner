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

import java.util.Objects;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import nl.robominer.entity.Users;

/**
 * Session bean for the Users entity class.
 *
 * @author Arnoud Jagerman
 */
@Stateless
public class UsersFacade extends AbstractFacade<Users> {

    /**
     * Write result type.
     */
    public enum EWriteResult {
        eSuccess,
        eDuplicateUsername,
        eDuplicateEmail
    }

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
    public UsersFacade() {
        super(Users.class);
    }

    /**
     * Add a new Users instance to the database, if possible.
     *
     * @param users The Users instance to add to the database.
     *
     * @return <code>eSuccess</code> when successful, or the reason
     * why the database insert failed.
     */
    public EWriteResult createNew(Users users) {

        EWriteResult result;

        if (findByUsername(users.getUsername()) != null) {
            result = EWriteResult.eDuplicateUsername;
        }
        else if (findByEmail(users.getEmail()) != null) {
            result = EWriteResult.eDuplicateEmail;
        }
        else {
            super.create(users);

            // Flush the sql queries to make sure the primary key value is available.
            em.flush();

            result = EWriteResult.eSuccess;
        }

        return result;
    }

    /**
     * Update the Users instance in the database, if possible.
     *
     * @param users The Users instance to update in the database.
     *
     * @return <code>eSuccess</code> when successful, or the reason
     * why the database update failed.
     */
    public EWriteResult update(Users users) {

        EWriteResult result;

        Users duplicateUsername = findByUsername(users.getUsername());
        Users duplicateEmail    = findByEmail(users.getEmail());

        if (duplicateUsername != null &&
            !Objects.equals(duplicateUsername.getId(), users.getId())) {

            result = EWriteResult.eDuplicateUsername;
        }
        else if (duplicateEmail != null &&
                 !Objects.equals(duplicateEmail.getId(), users.getId())) {

            result = EWriteResult.eDuplicateEmail;
        }
        else {
            super.edit(users);
            result = EWriteResult.eSuccess;
        }

        return result;
    }

    /**
     * Find a Users record with the specified primary key value.
     *
     * @param id The primary key value to retrieve the Users instance for.
     *
     * @return The Users instance for the specified primary key value, or null
     * if not found.
     */
    public Users findById(int id) {

        try {
            Query query = getEntityManager().createNamedQuery("Users.findById", Users.class);
            query.setParameter("id", id);
            return (Users)query.getSingleResult();
        }
        catch (javax.persistence.NoResultException exc) {
            return null;
        }
    }

    /**
     * Find a Users record with the specified username value.
     *
     * @param username The username value to retrieve the Users instance for.
     *
     * @return The Users instance for the specified username value, or null
     * if not found.
     */
    public Users findByUsername(String username) {

        try {
            Query query = getEntityManager().createNamedQuery("Users.findByUsername", Users.class);
            query.setParameter("username", username);
            return (Users)query.getSingleResult();
        }
        catch (javax.persistence.NoResultException exc) {
            return null;
        }
    }

    /**
     * Find a Users record with the specified email value.
     *
     * @param email The email value to retrieve the Users instance for.
     *
     * @return The Users instance for the specified email value, or null
     * if not found.
     */
    public Users findByEmail(String email) {

        try {
            Query query = getEntityManager().createNamedQuery("Users.findByEmail", Users.class);
            query.setParameter("email", email);
            return (Users)query.getSingleResult();
        }
        catch (javax.persistence.NoResultException exc) {
            return null;
        }
    }

    /**
     * Find a Users record where the specified value matches the username or
     * email address.
     *
     * @param name The value which should match the username or email value.
     *
     * @return The found Users instance, or null if not found.
     */
    public Users findByUsernameOrEmail(String name) {

        try {
            Query query = getEntityManager().createNamedQuery("Users.findByUsernameOrEmail", Users.class);
            query.setParameter("name", name);
            return (Users)query.getSingleResult();
        }
        catch (javax.persistence.NoResultException exc) {
            return null;
        }
    }

}
