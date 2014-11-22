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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Entity class for the Robot Actions data.
 *
 * @author Arnoud Jagerman
 */
@Entity
@Table(name = "RobotActionsDone")
@XmlRootElement
@NamedQueries(
{
    @NamedQuery(name = "RobotActionsDone.findAll",
                query = "SELECT r FROM RobotActionsDone r"),
    @NamedQuery(name = "RobotActionsDone.findByMiningQueueId",
                query = "SELECT r FROM RobotActionsDone r WHERE r.miningQueueId = :miningQueueId")
})
public class RobotActionsDone implements Serializable
{
    private static final long serialVersionUID = 1L;

    /**
     * The primary key value.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    /**
     * The mining queue item id this robot action is done for.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "miningQueueId")
    private int miningQueueId;

    /**
     * The type of action this robot action represents.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "actionType")
    private int actionType;

    /**
     * The number of times this action was done.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "amount")
    private int amount;

    /**
     * Default constructor.
     */
    public RobotActionsDone()
    {
    }

    /**
     * Retrieve the primary key value.
     *
     * @return The primary key value.
     */
    public Integer getId()
    {
        return id;
    }

    /**
     * Retrieve the MiningQueueId value this instance represents.
     *
     * @return The MiningQueueId value this instance represents.
     */
    public int getMiningQueueId()
    {
        return miningQueueId;
    }

    /**
     * Retrieve the action type this instance represents. See the
     * CRobot::EAction enumeration in the C++ part for the meaning of the
     * values.
     *
     * @return The action type this instance represents.
     */
    public int getActionType()
    {
        return actionType;
    }

    /**
     * Retrieve the number of times this action was performed in this mining
     * run.
     *
     * @return The number of times this action was performed in this mining run.
     */
    public int getAmount()
    {
        return amount;
    }

    /**
     * Retrieve a hash value for this instance.
     *
     * @return The hash value for this instance.
     */
    @Override
    public int hashCode()
    {
        return (id != null ? id.hashCode() : 0);
    }

    /**
     * Compares this instance with another instance of RobotActionsDone.
     *
     * @param object The other instance to compare with.
     *
     * @return true when both instances represent the same database value,
     *         false otherwise.
     */
    @Override
    public boolean equals(Object object)
    {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RobotActionsDone))
        {
            return false;
        }

        RobotActionsDone other = (RobotActionsDone)object;

        return (this.id != null && other.id != null && this.id.equals(other.id));
    }

    /**
     * Retrieve a string representation of this instance.
     *
     * @return A string representation of this instance.
     */
    @Override
    public String toString()
    {
        return "nl.robominer.entity.RobotActionsDone[ id=" + id + " ]";
    }
}
