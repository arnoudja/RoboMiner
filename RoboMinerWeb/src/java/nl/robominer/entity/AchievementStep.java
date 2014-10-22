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
import java.util.List;
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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Arnoud Jagerman
 */
@Entity
@Table(name = "AchievementStep")
@XmlRootElement
@NamedQueries(
{
    @NamedQuery(name = "AchievementStep.findAll",
                query = "SELECT a FROM AchievementStep a"),
    @NamedQuery(name = "AchievementStep.findById",
                query = "SELECT a FROM AchievementStep a WHERE a.id = :id"),
    @NamedQuery(name = "AchievementStep.findByAchievementId",
                query = "SELECT a FROM AchievementStep a WHERE a.achievementId = :achievementId")
})
public class AchievementStep implements Serializable
{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    @Basic(optional = false)
    @NotNull
    @Column(name = "achievementId")
    private int achievementId;

    @Basic(optional = false)
    @NotNull
    @Column(name = "step")
    private int step;

    @Basic(optional = false)
    @NotNull
    @Column(name = "achievementPoints")
    private int achievementPoints;

    @Basic(optional = false)
    @NotNull
    @Column(name = "miningQueueReward")
    private int miningQueueReward;

    @Basic(optional = false)
    @NotNull
    @Column(name = "robotReward")
    private int robotReward;

    @ManyToOne
    @JoinColumn(name = "miningAreaId")
    private MiningArea miningArea;

    @OneToMany
    @JoinColumn(name = "AchievementStepMiningTotalRequirement.achievementStepId")
    private List<AchievementStepMiningTotalRequirement> achievementStepMiningTotalRequirementList;

    @OneToMany
    @JoinColumn(name = "AchievementStepMiningScoreRequirement.achievementStepId")
    private List<AchievementStepMiningScoreRequirement> achievementStepMiningScoreRequirementList;

    public AchievementStep()
    {
    }

    public Integer getId()
    {
        return id;
    }

    public int getAchievementId()
    {
        return achievementId;
    }

    /**
     * Retrieve the step number of this achievement step.
     *
     * @return The step number of this achievement step.
     */
    public int getStep()
    {
        return step;
    }

    /**
     * Retrieve the number of achievement points awarded when completing this step.
     *
     * @return The number of achievement points awarded when completing this step.
     */
    public int getAchievementPoints()
    {
        return achievementPoints;
    }

    /**
     * Retrieve the mining queue size increment awarded by completing this step.
     *
     * @return The mining queue size increment awarded by completing this step.
     */
    public int getMiningQueueReward()
    {
        return miningQueueReward;
    }

    /**
     * Retrieve the robot reward for this achievement step.
     *
     * @return The number of robots after completing this achievement step.
     */
    public int getRobotReward()
    {
        return robotReward;
    }

    /**
     * Retrieve the mining area reward for this achievement step.
     *
     * @return The mining area reward, or null if none.
     */
    public MiningArea getMiningArea()
    {
        return miningArea;
    }

    /**
     * Retrieve the list of mining total requirements for this achievement step.
     *
     * @return The list of mining total requirements for this achievement step.
     */
    public List<AchievementStepMiningTotalRequirement> getAchievementStepMiningTotalRequirementList()
    {
        return achievementStepMiningTotalRequirementList;
    }

    /**
     * Retrieve the list of mining score requirements for this achievement step.
     *
     * @return The list of mining score requirements for this achievement step.
     */
    public List<AchievementStepMiningScoreRequirement> getAchievementStepMiningScoreRequirementList()
    {
        return achievementStepMiningScoreRequirementList;
    }

    /**
     * Check whether the requirements for this achievement step are met by the specified user.
     *
     * @param user The user to check the requirements against.
     *
     * @return true if all requirements are met, else false.
     */
    public boolean isAchievedByUser(Users user)
    {
        for (AchievementStepMiningTotalRequirement achievementStepMiningTotalRequirement : achievementStepMiningTotalRequirementList)
        {
            if (!achievementStepMiningTotalRequirement.isAchievedByUser(user))
            {
                return false;
            }
        }

        for (AchievementStepMiningScoreRequirement achievementStepMiningScoreRequirement : achievementStepMiningScoreRequirementList)
        {
            if (!achievementStepMiningScoreRequirement.isAchievedByUser(user))
            {
                return false;
            }
        }

        return true;
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
        if (!(object instanceof AchievementStep))
        {
            return false;
        }

        AchievementStep other = (AchievementStep)object;

        return !((this.id == null && other.id != null) ||
                 (this.id != null && !this.id.equals(other.id)));
    }

    @Override
    public String toString()
    {
        return "nl.robominer.entity.AchievementStep[ id=" + id + " ]";
    }
}
