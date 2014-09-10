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
 *
 * @author Arnoud Jagerman
 */
@Entity
@Table(name = "RobotLifetimeResult")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RobotLifetimeResult.findAll", query = "SELECT r FROM RobotLifetimeResult r"),
    @NamedQuery(name = "RobotLifetimeResult.findByRobotId", query = "SELECT r FROM RobotLifetimeResult r WHERE r.robotLifetimeResultPK.robotId = :robotId"),
    @NamedQuery(name = "RobotLifetimeResult.findByRobotAndOreId", query = "SELECT r FROM RobotLifetimeResult r WHERE r.robotLifetimeResultPK.robotId = :robotId AND r.robotLifetimeResultPK.oreId = :oreId")})
public class RobotLifetimeResult implements Serializable {

    private static final long serialVersionUID = 1L;

    @EmbeddedId
    protected RobotLifetimeResultPK robotLifetimeResultPK;

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

    public RobotLifetimeResult() {
    }

    public RobotLifetimeResult(int robotId, int oreId, int amount, int tax) {
        this.robotLifetimeResultPK = new RobotLifetimeResultPK(robotId, oreId);
        this.amount = amount;
        this.tax = tax;
    }

    public RobotLifetimeResultPK getRobotLifetimeResultPK() {
        return robotLifetimeResultPK;
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
        hash += (robotLifetimeResultPK != null ? robotLifetimeResultPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RobotLifetimeResult)) {
            return false;
        }
        RobotLifetimeResult other = (RobotLifetimeResult) object;
        return (this.robotLifetimeResultPK != null || other.robotLifetimeResultPK == null) &&
               (this.robotLifetimeResultPK == null || this.robotLifetimeResultPK.equals(other.robotLifetimeResultPK));
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.RobotLifetimeResult[ robotLifetimeResultPK=" + robotLifetimeResultPK + " ]";
    }
    
}
