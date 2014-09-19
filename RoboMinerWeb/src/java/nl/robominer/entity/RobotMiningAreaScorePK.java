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
 * The primary key entity class for RobotMiningAreaScore.
 *
 * @author Arnoud Jagerman
 */
@Embeddable
public class RobotMiningAreaScorePK implements Serializable {

    /**
     * The robotId value part of the primary key.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "robotId")
    private int robotId;

    /**
     * The miningAreaId value part of the primary key.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "miningAreaId")
    private int miningAreaId;

    /**
     * Default constructor.
     */
    public RobotMiningAreaScorePK() {
    }

    /**
     * Retrieve the robot id part of the primary key value.
     * 
     * @return The robotId value.
     */
    public int getRobotId() {
        return robotId;
    }

    /**
     * Retrieve the mining area id part of the primary key value.
     *
     * @return The miningAreaId value.
     */
    public int getMiningAreaId() {
        return miningAreaId;
    }

    /**
     * Retrieve the hash value.
     *
     * @return The hash value.
     */
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) robotId;
        hash += (int) miningAreaId;
        return hash;
    }

    /**
     * Compares two instances of this class. Only instances for which the
     * primary key values are set can be compared.
     *
     * @param object The other instance of this class to compare to.
     * @return true when the instances represent the same primary key value,
     * else false.
     */
    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RobotMiningAreaScorePK)) {
            return false;
        }
        RobotMiningAreaScorePK other = (RobotMiningAreaScorePK) object;
        if (this.robotId != other.robotId) {
            return false;
        }
        return this.miningAreaId == other.miningAreaId;
    }

    /**
     * Retrieve a string representation of the instance data.
     *
     * @return A string representation of the instance data.
     */
    @Override
    public String toString() {
        return "nl.robominer.entity.RobotMiningAreaScorePK[ robotId=" + robotId + ", miningAreaId=" + miningAreaId + " ]";
    }

}
