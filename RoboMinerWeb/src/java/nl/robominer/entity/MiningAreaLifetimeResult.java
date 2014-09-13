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
@Table(name = "MiningAreaLifetimeResult")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "MiningAreaLifetimeResult.findAll", query = "SELECT m FROM MiningAreaLifetimeResult m"),
    @NamedQuery(name = "MiningAreaLifetimeResult.findByMiningAreaId", query = "SELECT m FROM MiningAreaLifetimeResult m WHERE m.miningAreaLifetimeResultPK.miningAreaId = :miningAreaId"),
    @NamedQuery(name = "MiningAreaLifetimeResult.findByPK", query = "SELECT m FROM MiningAreaLifetimeResult m WHERE m.miningAreaLifetimeResultPK.miningAreaId = :miningAreaId AND m.miningAreaLifetimeResultPK.oreId = :oreId")})
public class MiningAreaLifetimeResult implements Serializable {

    private static final long serialVersionUID = 1L;

    @EmbeddedId
    protected MiningAreaLifetimeResultPK miningAreaLifetimeResultPK;

    @Basic(optional = false)
    @NotNull
    @Column(name = "totalAmount")
    private long totalAmount;

    @Basic(optional = false)
    @NotNull
    @Column(name = "totalContainerSize")
    private long totalContainerSize;

    @ManyToOne
    @JoinColumn(name = "oreId", insertable = false, updatable = false)
    private Ore ore;

    public MiningAreaLifetimeResult() {
    }

    public MiningAreaLifetimeResult(int miningAreaId, int oreId, int amount, int containerSize) {
        this.miningAreaLifetimeResultPK = new MiningAreaLifetimeResultPK(miningAreaId, oreId);
        this.totalAmount = amount;
        this.totalContainerSize = containerSize;
    }

    public long getTotalAmount() {
        return totalAmount;
    }

    public void increaseTotalAmount(int amount) {
        this.totalAmount += amount;
    }

    public long getTotalContainerSize() {
        return totalContainerSize;
    }

    public void increaseTotalContainerSize(int containerSize) {
        this.totalContainerSize += containerSize;
    }

    public Ore getOre() {
        return ore;
    }

    public double getPercentage() {
        return (totalAmount * 100.0 / totalContainerSize);
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (miningAreaLifetimeResultPK != null ? miningAreaLifetimeResultPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof MiningAreaLifetimeResult)) {
            return false;
        }
        MiningAreaLifetimeResult other = (MiningAreaLifetimeResult) object;
        return (this.miningAreaLifetimeResultPK != null || other.miningAreaLifetimeResultPK == null) &&
               (this.miningAreaLifetimeResultPK == null || this.miningAreaLifetimeResultPK.equals(other.miningAreaLifetimeResultPK));
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.MiningAreaLifetimeResult[ miningAreaLifetimeResultPK=" + miningAreaLifetimeResultPK + " ]";
    }
    
}
