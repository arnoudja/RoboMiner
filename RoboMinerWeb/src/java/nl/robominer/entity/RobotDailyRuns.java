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
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
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
@Table(name = "RobotDailyRuns")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RobotDailyRuns.findByRobotId", query = "SELECT r FROM RobotDailyRuns r WHERE r.robotDailyRunsPK.robotId = :robotId"),
    @NamedQuery(name = "RobotDailyRuns.findByRobotIdAndMiningDay", query = "SELECT r FROM RobotDailyRuns r WHERE r.robotDailyRunsPK.robotId = :robotId AND r.robotDailyRunsPK.miningDay = :miningDay")})
public class RobotDailyRuns implements Serializable {

    private static final long serialVersionUID = 1L;

    @EmbeddedId
    protected RobotDailyRunsPK robotDailyRunsPK;

    @Basic(optional = false)
    @NotNull
    @Column(name = "totalMiningRuns")
    private int totalMiningRuns;

    public RobotDailyRuns() {
    }

    public RobotDailyRuns(int robotId, Date miningDay, int totalMiningRuns) {
        this.robotDailyRunsPK = new RobotDailyRunsPK(robotId, miningDay);
        this.totalMiningRuns = totalMiningRuns;
    }

    public RobotDailyRunsPK getRobotDailyRunsPK() {
        return robotDailyRunsPK;
    }

    public int getTotalMiningRuns() {
        return totalMiningRuns;
    }

    public void increaseTotalMiningRuns() {
        ++totalMiningRuns;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (robotDailyRunsPK != null ? robotDailyRunsPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RobotDailyRuns)) {
            return false;
        }
        RobotDailyRuns other = (RobotDailyRuns) object;
        return (this.robotDailyRunsPK != null || other.robotDailyRunsPK == null) &&
               (this.robotDailyRunsPK == null || this.robotDailyRunsPK.equals(other.robotDailyRunsPK));
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.RobotDailyRuns[ robotDailyRunsPK=" + robotDailyRunsPK + " ]";
    }
    
}
