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
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
@Table(name = "AchievementStepMiningScoreRequirement")
@XmlRootElement
@NamedQueries(
{
    @NamedQuery(
            name = "AchievementStepMiningScoreRequirement.findByAchievementStepId",
            query = "SELECT a FROM AchievementStepMiningScoreRequirement a WHERE a.achievementStepId = :achievementStepId")
})
public class AchievementStepMiningScoreRequirement implements Serializable
{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    @Basic(optional = false)
    @NotNull
    @Column(name = "achievementStepId")
    private int achievementStepId;

    @ManyToOne
    @JoinColumn(name = "miningAreaId")
    private MiningArea miningArea;

    @Basic(optional = false)
    @NotNull
    @Column(name = "minimumScore")
    private double minimumScore;

    public AchievementStepMiningScoreRequirement()
    {
    }

    public Integer getId()
    {
        return id;
    }

    public int getAchievementStepId()
    {
        return achievementStepId;
    }

    /**
     * Retrieve the mining area for this requirement.
     *
     * @return The mining area for this requirement.
     */
    public MiningArea getMiningArea()
    {
        return miningArea;
    }

    /**
     * Retrieve the minimum score for this requirement.
     *
     * @return The minimum score for this requirement.
     */
    public double getMinimumScore()
    {
        return minimumScore;
    }

    /**
     * Check whether this requirement is met by the specified user.
     *
     * @param user The user to check this requirement for.
     *
     * @return true if the requirement is met by the specified user, else false.
     */
    public boolean isAchievedByUser(Users user)
    {
        return (user.getMiningAreaScore(miningArea.getId()) >= minimumScore);
    }

    @Override
    public int hashCode()
    {
        return (id != null ? id.hashCode() : 0);
    }

    @Override
    public boolean equals(Object object)
    {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AchievementStepMiningScoreRequirement))
        {
            return false;
        }

        AchievementStepMiningScoreRequirement other = (AchievementStepMiningScoreRequirement)object;
        return !((this.id == null && other.id != null) ||
                 (this.id != null && !this.id.equals(other.id)));
    }

    @Override
    public String toString()
    {
        return "nl.robominer.entity.AchievementStepMiningScoreRequirement[ id=" +
                id + " ]";
    }
}
