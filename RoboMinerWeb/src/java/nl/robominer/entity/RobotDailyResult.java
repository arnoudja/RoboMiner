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
@Table(name = "RobotDailyResult")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RobotDailyResult.findByRobotId", query = "SELECT r FROM RobotDailyResult r WHERE r.robotDailyResultPK.robotId = :robotId"),
    @NamedQuery(name = "RobotDailyResult.findByRobotIdAndMiningDayRange", query = "SELECT r FROM RobotDailyResult r WHERE r.robotDailyResultPK.robotId = :robotId AND r.robotDailyResultPK.miningDay >= :firstMiningDay AND r.robotDailyResultPK.miningDay <= :lastMiningDay"),
    @NamedQuery(name = "RobotDailyResult.findByPK", query = "SELECT r FROM RobotDailyResult r WHERE r.robotDailyResultPK.robotId = :robotId AND r.robotDailyResultPK.oreId = :oreId AND r.robotDailyResultPK.miningDay = :miningDay")})
public class RobotDailyResult implements Serializable {

    private static final long serialVersionUID = 1L;

    @EmbeddedId
    protected RobotDailyResultPK robotDailyResultPK;

    @Basic(optional = false)
    @NotNull
    @Column(name = "amount")
    private int amount;

    @Basic(optional = false)
    @NotNull
    @Column(name = "tax")
    private int tax;

    @ManyToOne
    @JoinColumn(name = "oreId", insertable = false, updatable = false)
    private Ore ore;

    public RobotDailyResult() {
    }

    public RobotDailyResult(int robotId, int oreId, Date miningDay, int amount, int tax) {
        this.robotDailyResultPK = new RobotDailyResultPK(robotId, oreId, miningDay);
        this.amount = amount;
        this.tax = tax;
    }

    public RobotDailyResultPK getRobotDailyResultPK() {
        return robotDailyResultPK;
    }

    public int getAmount() {
        return amount;
    }

    public void increaseAmount(int amount) {
        this.amount += amount;
    }

    public int getTax() {
        return tax;
    }

    public void increaseTax(int tax) {
        this.tax += tax;
    }

    public Ore getOre() {
        return ore;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (robotDailyResultPK != null ? robotDailyResultPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RobotDailyResult)) {
            return false;
        }
        RobotDailyResult other = (RobotDailyResult) object;
        return (this.robotDailyResultPK != null || other.robotDailyResultPK == null) &&
               (this.robotDailyResultPK == null || this.robotDailyResultPK.equals(other.robotDailyResultPK));
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.RobotDailyResult[ robotDailyResultPK=" + robotDailyResultPK + " ]";
    }
    
}
