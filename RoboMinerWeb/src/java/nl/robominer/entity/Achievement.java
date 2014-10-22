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
import java.util.Map;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.MapKey;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Arnoud Jagerman
 */
@Entity
@Table(name = "Achievement")
@XmlRootElement
@NamedQueries(
{
    @NamedQuery(name = "Achievement.findAll",
                query = "SELECT a FROM Achievement a"),
    @NamedQuery(name = "Achievement.findById",
                query = "SELECT a FROM Achievement a WHERE a.id = :id")
})
public class Achievement implements Serializable
{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "title")
    private String title;

    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 65535)
    @Column(name = "description")
    private String description;

    @OneToMany
    @JoinColumn(name = "AchievementStep.achievementId")
    @MapKey(name = "step")
    private Map<Integer, AchievementStep> achievementStepMap;

    @OneToMany
    @JoinColumn(name = "AchievementPredecessor.predecessorId")
    private List<AchievementPredecessor> achievementSuccessorList;

    @OneToMany
    @JoinColumn(name = "AchievementPredecessor.successorId")
    private List<AchievementPredecessor> achievementPredecessorList;

    @Transient
    private int totalAchievementPoints = -1;

    public Achievement()
    {
    }

    public Integer getId()
    {
        return id;
    }

    /**
     * Retrieve the title of the achievement.
     *
     * @return The title of the achievement.
     */
    public String getTitle()
    {
        return title;
    }

    /**
     * Retrieve the description of the achievement.
     *
     * @return The description of the achievement.
     */
    public String getDescription()
    {
        return description;
    }

    /**
     * Retrieve the total number of achievement steps.
     *
     * @return The total number of achievement steps.
     */
    public int getNumberOfSteps()
    {
        return achievementStepMap.size();
    }

    /**
     * Retrieve the specified achievement step.
     *
     * @param step The step number to retrieve the achievement step for.
     *
     * @return The achievement step information, or null if the specified
     * step does not exist.
     */
    public AchievementStep getAchievementStep(int step)
    {
        return achievementStepMap.get(step);
    }

    /**
     * Retrieve the list of predecessors for this achievement.
     *
     * @return The list of predecessors for this achievement.
     */
    public List<AchievementPredecessor> getAchievementPredecessorList()
    {
        return achievementPredecessorList;
    }

    /**
     * Retrieve the list of successors for this achievement.
     *
     * @return The list of successors for this achievement.
     */
    public List<AchievementPredecessor> getAchievementSuccessorList()
    {
        return achievementSuccessorList;
    }

    /**
     * Retrieve the total number of achievement points for all steps.
     *
     * @return The total number of achievement points for all steps.
     */
    public int getTotalAchievementPoints()
    {
        if (totalAchievementPoints < 0)
        {
            totalAchievementPoints = 0;

            for (AchievementStep achievementStep : achievementStepMap.values())
            {
                totalAchievementPoints += achievementStep.getAchievementPoints();
            }
        }

        return totalAchievementPoints;
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
        if (!(object instanceof Achievement))
        {
            return false;
        }

        Achievement other = (Achievement)object;
        return (this.id != null || other.id == null) &&
                (this.id == null || this.id.equals(other.id));
    }

    @Override
    public String toString()
    {
        return "nl.robominer.entity.Achievement[ id=" + id + " ]";
    }
}
