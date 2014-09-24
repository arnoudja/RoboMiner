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
public class AchievementMiningScoreRequirementPK implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "achievementId")
    private int achievementId;

    @Basic(optional = false)
    @NotNull
    @Column(name = "miningAreaId")
    private int miningAreaId;

    public AchievementMiningScoreRequirementPK() {
    }

    public int getAchievementId() {
        return achievementId;
    }

    public int getMiningAreaId() {
        return miningAreaId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) achievementId;
        hash += (int) miningAreaId;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AchievementMiningScoreRequirementPK)) {
            return false;
        }
        AchievementMiningScoreRequirementPK other = (AchievementMiningScoreRequirementPK) object;
        if (this.achievementId != other.achievementId) {
            return false;
        }
        return this.miningAreaId == other.miningAreaId;
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.AchievementMiningScoreRequirementPK[ achievementId=" + achievementId + ", miningAreaId=" + miningAreaId + " ]";
    }

}
