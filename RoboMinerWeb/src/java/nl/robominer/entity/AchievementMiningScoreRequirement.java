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
@Table(name = "AchievementMiningScoreRequirement")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "AchievementMiningScoreRequirement.findAll", query = "SELECT a FROM AchievementMiningScoreRequirement a"),
    @NamedQuery(name = "AchievementMiningScoreRequirement.findByAchievementId", query = "SELECT a FROM AchievementMiningScoreRequirement a WHERE a.achievementMiningScoreRequirementPK.achievementId = :achievementId")})
public class AchievementMiningScoreRequirement implements Serializable {

    private static final long serialVersionUID = 1L;

    @EmbeddedId
    protected AchievementMiningScoreRequirementPK achievementMiningScoreRequirementPK;

    @Basic(optional = false)
    @NotNull
    @Column(name = "minimumScore")
    private double minimumScore;

    @ManyToOne
    @JoinColumn(name = "miningAreaId", insertable = false, updatable = false)
    private MiningArea miningArea;

    public AchievementMiningScoreRequirement() {
    }

    public AchievementMiningScoreRequirementPK getAchievementMiningScoreRequirementPK() {
        return achievementMiningScoreRequirementPK;
    }

    public MiningArea getMiningArea() {
        return miningArea;
    }

    public int getMiningAreaId() {
        return achievementMiningScoreRequirementPK.getMiningAreaId();
    }

    public double getMinimumScore() {
        return minimumScore;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (achievementMiningScoreRequirementPK != null ? achievementMiningScoreRequirementPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AchievementMiningScoreRequirement)) {
            return false;
        }
        AchievementMiningScoreRequirement other = (AchievementMiningScoreRequirement) object;
        return !((this.achievementMiningScoreRequirementPK == null && other.achievementMiningScoreRequirementPK != null) ||
                 (this.achievementMiningScoreRequirementPK != null && !this.achievementMiningScoreRequirementPK.equals(other.achievementMiningScoreRequirementPK)));
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.AchievementMiningScoreRequirement[ achievementMiningScoreRequirementPK=" + achievementMiningScoreRequirementPK + " ]";
    }
    
}
