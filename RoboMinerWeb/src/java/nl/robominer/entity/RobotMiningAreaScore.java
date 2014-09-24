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
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * An entity class representing the RoboMiningAreaScore database values.
 *
 * @author Arnoud Jagerman
 */
@Entity
@Table(name = "RobotMiningAreaScore")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RobotMiningAreaScore.findAll", query = "SELECT r FROM RobotMiningAreaScore r"),
    @NamedQuery(name = "RobotMiningAreaScore.findByRobotId", query = "SELECT r FROM RobotMiningAreaScore r WHERE r.robotMiningAreaScorePK.robotId = :robotId"),
    @NamedQuery(name = "RobotMiningAreaScore.findByMiningAreaId", query = "SELECT r FROM RobotMiningAreaScore r WHERE r.robotMiningAreaScorePK.miningAreaId = :miningAreaId AND r.totalRuns >= :minimumRuns ORDER BY r.score DESC")})
public class RobotMiningAreaScore implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * The primary key value.
     */
    @EmbeddedId
    protected RobotMiningAreaScorePK robotMiningAreaScorePK;

    /**
     * The total number of runs this robot made in this mining area.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "totalRuns")
    private int totalRuns;

    /**
     * The score of this robot for this mining area.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "score")
    private double score;

    /**
     * The robot this score is for.
     */
    @ManyToOne
    @JoinColumn(name = "robotId", insertable = false, updatable = false)
    private Robot robot;

    /**
     * Default constructor.
     */
    public RobotMiningAreaScore() {
    }

    /**
     * Retrieve the primary key value of this instance.
     *
     * @return The primary key value of this instance.
     */
    public RobotMiningAreaScorePK getRobotMiningAreaScorePK() {
        return robotMiningAreaScorePK;
    }

    /**
     * Retrieve the mining area id this score is for.
     *
     * @return The mining area id.
     */
    public int getMiningAreaId() {
        return robotMiningAreaScorePK.getMiningAreaId();
    }

    /**
     * Retrieve the total number of runs made by this robot in this mining area.
     *
     * @return The total number of runs.
     */
    public int getTotalRuns() {
        return totalRuns;
    }

    /**
     * Retrieve the score of this robot for this mining area.
     *
     * @return The score value.
     */
    public double getScore() {
        return score;
    }

    /**
     * Retrieve the robot this score is for.
     *
     * @return The robot.
     */
    public Robot getRobot() {
        return robot;
    }

    /**
     * Retrieve a hash value for this instance.
     *
     * @return The calculated hash value.
     */
    @Override
    public int hashCode() {
        return (robotMiningAreaScorePK != null ? robotMiningAreaScorePK.hashCode() : 0);
    }

    /**
     * Compares two instances of this class. Only works if the primary key values
     * of both instances are set.
     *
     * @param object The other instance of this class to compare to.
     * @return true when the instances represent the same item, else false.
     */
    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RobotMiningAreaScore)) {
            return false;
        }
        RobotMiningAreaScore other = (RobotMiningAreaScore) object;
        return !((this.robotMiningAreaScorePK == null && other.robotMiningAreaScorePK != null) ||
                 (this.robotMiningAreaScorePK != null && !this.robotMiningAreaScorePK.equals(other.robotMiningAreaScorePK)));
    }

    /**
     * Retrieve a string representation of the id value of this instance.
     *
     * @return A string representation of the id value of this instance.
     */
    @Override
    public String toString() {
        return "nl.robominer.entity.RobotMiningAreaScore[ robotMiningAreaScorePK=" + robotMiningAreaScorePK + " ]";
    }

}
