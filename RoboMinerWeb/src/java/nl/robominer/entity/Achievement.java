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
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
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
@NamedQueries({
    @NamedQuery(name = "Achievement.findAll", query = "SELECT a FROM Achievement a"),
    @NamedQuery(name = "Achievement.findById", query = "SELECT a FROM Achievement a WHERE a.id = :id")})
public class Achievement implements Serializable {

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
    @JoinColumn(name = "miningAreaId", insertable = false, updatable = false)
    private MiningArea miningArea;

    @OneToMany
    @JoinColumn(name = "AchievementMiningTotalRequirement.achievementId")
    private List<AchievementMiningTotalRequirement> achievementMiningTotalRequirementList;

    @OneToMany
    @JoinColumn(name = "AchievementMiningScoreRequirement.achievementId")
    private List<AchievementMiningScoreRequirement> achievementMiningScoreRequirementList;

    @OneToMany
    @JoinTable(
            name = "AchievementPredecessor",
            joinColumns = @JoinColumn(name = "predecessorId"),
            inverseJoinColumns= @JoinColumn(name = "successorId")
    )
    private List<Achievement> achievementSuccessorList;

    public Achievement() {
    }

    public Integer getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public int getAchievementPoints() {
        return achievementPoints;
    }

    public int getMiningQueueReward() {
        return miningQueueReward;
    }

    public int getRobotReward() {
        return robotReward;
    }

    public MiningArea getMiningArea() {
        return miningArea;
    }

    public List<AchievementMiningTotalRequirement> getAchievementMiningTotalRequirementList() {
        return achievementMiningTotalRequirementList;
    }

    public List<AchievementMiningScoreRequirement> getAchievementMiningScoreRequirementList() {
        return achievementMiningScoreRequirementList;
    }

    public List<Achievement> getAchievementSuccessorList() {
        return achievementSuccessorList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Achievement)) {
            return false;
        }
        Achievement other = (Achievement) object;
        return (this.id != null || other.id == null) &&
               (this.id == null || this.id.equals(other.id));
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.Achievement[ id=" + id + " ]";
    }
    
}
