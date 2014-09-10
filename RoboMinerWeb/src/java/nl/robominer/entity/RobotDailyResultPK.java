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
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

/**
 *
 * @author Arnoud Jagerman
 */
@Embeddable
public class RobotDailyResultPK implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "robotId")
    private int robotId;

    @Basic(optional = false)
    @NotNull
    @Column(name = "oreId")
    private int oreId;

    @Basic(optional = false)
    @NotNull
    @Column(name = "miningDay")
    @Temporal(TemporalType.DATE)
    private Date miningDay;

    public RobotDailyResultPK() {
    }

    public RobotDailyResultPK(int robotId, int oreId, Date miningDay) {
        this.robotId = robotId;
        this.oreId = oreId;
        this.miningDay = miningDay;
    }

    public int getRobotId() {
        return robotId;
    }

    public int getOreId() {
        return oreId;
    }

    public Date getMiningDay() {
        return miningDay;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) robotId;
        hash += (int) oreId;
        hash += (miningDay != null ? miningDay.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RobotDailyResultPK)) {
            return false;
        }
        RobotDailyResultPK other = (RobotDailyResultPK) object;
        if (this.robotId != other.robotId) {
            return false;
        }
        if (this.oreId != other.oreId) {
            return false;
        }
        return (this.miningDay != null || other.miningDay == null) && 
               (this.miningDay == null || this.miningDay.equals(other.miningDay));
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.RobotDailyResultPK[ robotId=" + robotId + ", oreId=" + oreId + ", miningDay=" + miningDay + " ]";
    }
    
}
