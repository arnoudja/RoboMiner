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
@Table(name = "MiningOreResult")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "MiningOreResult.findAll", query = "SELECT m FROM MiningOreResult m"),
    @NamedQuery(name = "MiningOreResult.findByMiningQueueId", query = "SELECT m FROM MiningOreResult m WHERE m.miningOreResultPK.miningQueueId = :miningQueueId"),
    @NamedQuery(name = "MiningOreResult.findByOreId", query = "SELECT m FROM MiningOreResult m WHERE m.miningOreResultPK.oreId = :oreId"),
    @NamedQuery(name = "MiningOreResult.findByAmount", query = "SELECT m FROM MiningOreResult m WHERE m.amount = :amount")})
public class MiningOreResult implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @EmbeddedId
    protected MiningOreResultPK miningOreResultPK;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "amount")
    private int amount;
    
    @ManyToOne
    @JoinColumn(name = "miningQueueId", insertable = false, updatable = false)
    private MiningQueue miningQueue;

    @ManyToOne
    @JoinColumn(name = "oreId", insertable = false, updatable = false)
    private Ore ore;

    public MiningOreResult() {
    }

    public MiningOreResult(MiningOreResultPK miningOreResultPK) {
        this.miningOreResultPK = miningOreResultPK;
    }

    public MiningOreResult(MiningOreResultPK miningOreResultPK, int amount) {
        this.miningOreResultPK = miningOreResultPK;
        this.amount = amount;
    }

    public MiningOreResult(int miningQueueId, int oreId) {
        this.miningOreResultPK = new MiningOreResultPK(miningQueueId, oreId);
    }

    public MiningOreResultPK getMiningOreResultPK() {
        return miningOreResultPK;
    }

    public Ore getOre() {
        return ore;
    }
    
    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public MiningQueue getMiningQueue() {
        return miningQueue;
    }
    
    public int getTax() {
        return (int)Math.floor(amount * miningQueue.getMiningArea().getTaxRate() / 100);
    }
    
    public int getReward() {
        return amount - getTax();
    }
    
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (miningOreResultPK != null ? miningOreResultPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof MiningOreResult)) {
            return false;
        }
        MiningOreResult other = (MiningOreResult) object;
        return (this.miningOreResultPK != null || other.miningOreResultPK == null) && (this.miningOreResultPK == null || this.miningOreResultPK.equals(other.miningOreResultPK));
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.MiningOreResult[ miningOreResultPK=" + miningOreResultPK + " ]";
    }
    
}
