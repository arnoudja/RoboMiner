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
 *
 * @author Arnoud Jagerman
 */
@Embeddable
public class MiningOreResultPK implements Serializable {
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "miningQueueId")
    private int miningQueueId;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "oreId")
    private int oreId;

    public MiningOreResultPK() {
    }

    public MiningOreResultPK(int miningQueueId, int oreId) {
        this.miningQueueId = miningQueueId;
        this.oreId = oreId;
    }

    public int getMiningQueueId() {
        return miningQueueId;
    }

    public void setMiningQueueId(int miningQueueId) {
        this.miningQueueId = miningQueueId;
    }

    public int getOreId() {
        return oreId;
    }

    public void setOreId(int oreId) {
        this.oreId = oreId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) miningQueueId;
        hash += (int) oreId;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof MiningOreResultPK)) {
            return false;
        }
        MiningOreResultPK other = (MiningOreResultPK) object;
        if (this.miningQueueId != other.miningQueueId) {
            return false;
        }
        if (this.oreId != other.oreId) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.MiningOreResultPK[ miningQueueId=" + miningQueueId + ", oreId=" + oreId + " ]";
    }
    
}
