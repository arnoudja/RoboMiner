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
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

/**
 * The primary key entity for RobotActionsDone.
 *
 * @author Arnoud Jagerman
 */
@Embeddable
public class RobotActionsDonePK implements Serializable
{
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
     * Default constructor.
     */
    public RobotActionsDonePK()
    {
    }

    /**
     * Retrieve the mining queue id part of the primary key.
     *
     * @return The mining queue id part of the primary key.
     */
    public int getMiningQueueId()
    {
        return miningQueueId;
    }

    /**
     * Retrieve the action type part of the primary key.
     *
     * @return The action type part of the primary key.
     */
    public int getActionType()
    {
        return actionType;
    }

    /**
     * Retrieve a hash value for this instance.
     *
     * @return The hash value for this instance.
     */
    @Override
    public int hashCode()
    {
        return miningQueueId + actionType;
    }

    /**
     * Compares this instance with another instance of RobotActionsDonePK.
     *
     * @param object The other instance to compare with.
     *
     * @return true when both instances represent the same primary key value,
     *         false otherwise.
     */
    @Override
    public boolean equals(Object object)
    {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RobotActionsDonePK))
        {
            return false;
        }

        RobotActionsDonePK other = (RobotActionsDonePK)object;

        return (miningQueueId == other.miningQueueId &&
                actionType == other.actionType);
    }

    /**
     * Retrieve a string representation of this instance.
     *
     * @return A string representation of this instance.
     */
    @Override
    public String toString()
    {
        return "nl.robominer.entity.RobotActionsDonePK[ miningQueueId=" +
                miningQueueId + ", actionType=" + actionType + " ]";
    }
}
