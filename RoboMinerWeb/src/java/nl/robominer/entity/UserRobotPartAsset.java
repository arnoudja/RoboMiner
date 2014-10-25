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

package nl.robominer.entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Arnoud Jagerman
 */
@Entity
@Table(name = "UserRobotPartAsset")
@XmlRootElement
@NamedQueries(
{
    @NamedQuery(name = "UserRobotPartAsset.findAll",
                query = "SELECT u FROM UserRobotPartAsset u"),
    @NamedQuery(name = "UserRobotPartAsset.clearByUsersId",
                query = "DELETE FROM UserRobotPartAsset u WHERE u.user.id = :usersId AND u.totalOwned = 0")
})
public class UserRobotPartAsset implements Serializable
{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    @ManyToOne
    @NotNull
    @JoinColumn(name = "usersId")
    private Users user;

    @ManyToOne
    @JoinColumn(name = "robotPartId")
    private RobotPart robotPart;

    @Basic(optional = false)
    @NotNull
    @Column(name = "totalOwned")
    private int totalOwned;

    public UserRobotPartAsset()
    {
    }

    public UserRobotPartAsset(Users user, RobotPart robotPart, int totalOwned)
    {
        this.user       = user;
        this.robotPart  = robotPart;
        this.totalOwned = totalOwned;
    }

    public RobotPart getRobotPart()
    {
        return robotPart;
    }

    /**
     * Retrieve the total amount of robot parts of this type owned by this user.
     *
     * @return The total amount of robot parts of this type owned by this user.
     */
    public int getTotalOwned()
    {
        return totalOwned;
    }

    /**
     * Retrieve the amount of robot parts of this type owned by this user that
     * aren't in use by a robot.
     *
     * @return The unassigned amount of robot parts.
     */
    public int getUnassigned()
    {
        return totalOwned - user.countRobotPartUsage(robotPart);
    }

    /**
     * Increase the amount of robot parts of this type for this user by one.
     */
    public void addOneOwned()
    {
        ++totalOwned;
    }

    /**
     * Decrease the amount of robot parts of this type for this user by one.
     *
     * @throws IllegalStateException When the user doesn't own an unassigned
     * robot part of this type.
     */
    public void removeOneOwned() throws IllegalStateException
    {
        if (getUnassigned() < 1)
        {
            throw new IllegalStateException();
        }

        --totalOwned;
    }

    @Override
    public int hashCode()
    {
        return (id != null ? id.hashCode() : 0);
    }

    @Override
    public boolean equals(Object object)
    {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof UserRobotPartAsset))
        {
            return false;
        }

        UserRobotPartAsset other = (UserRobotPartAsset)object;
        return !((this.id == null && other.id != null) ||
                 (this.id != null && !this.id.equals(other.id)));
    }

    @Override
    public String toString()
    {
        return "nl.robominer.entity.UserRobotPartAsset[ id=" + id + " ]";
    }
}
