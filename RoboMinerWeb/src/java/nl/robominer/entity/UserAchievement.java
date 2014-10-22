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
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Arnoud Jagerman
 */
@Entity
@Table(name = "UserAchievement")
@XmlRootElement
@NamedQueries(
{
    @NamedQuery(name = "UserAchievement.findByUsersId",
                query = "SELECT u FROM UserAchievement u WHERE u.user.id = :usersId"),
    @NamedQuery(name = "UserAchievement.findByUsersAndAchievementId",
                query = "SELECT u FROM UserAchievement u WHERE u.user.id = :usersId AND u.achievement.id = :achievementId")
})
public class UserAchievement implements Serializable
{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    @ManyToOne
    @NotNull
    @JoinColumn(name = "usersId")
    private Users user;

    @ManyToOne
    @NotNull
    @JoinColumn(name = "achievementId")
    private Achievement achievement;

    @Basic(optional = false)
    @NotNull
    @Column(name = "stepsClaimed")
    private int stepsClaimed;

    public UserAchievement()
    {
    }

    public UserAchievement(Users user, Achievement achievement)
    {
        this.user = user;
        this.achievement = achievement;
        this.stepsClaimed = 0;
    }

    public Integer getId()
    {
        return id;
    }

    public Users getUser()
    {
        return user;
    }

    public void setUser(Users user)
    {
        this.user = user;
    }

    public Achievement getAchievement()
    {
        return achievement;
    }

    public int getStepsClaimed()
    {
        return stepsClaimed;
    }

    public void setStepsClaimed(int stepsClaimed)
    {
        this.stepsClaimed = stepsClaimed;
    }

    public int getAchievementPointsEarned()
    {
        int total = 0;

        for (int i = 1; i <= stepsClaimed; ++i)
        {
            total += achievement.getAchievementStep(i).getAchievementPoints();
        }
        
        return total;
    }

    public boolean isClaimable()
    {
        AchievementStep achievementStep = achievement.getAchievementStep(stepsClaimed + 1);

        return (achievementStep != null && achievementStep.isAchievedByUser(user));
    }

    public boolean claimNextStep()
    {
        AchievementStep achievementStep = achievement.getAchievementStep(stepsClaimed + 1);

        if (achievementStep == null || !achievementStep.isAchievedByUser(user))
        {
            return false;
        }
        
        ++stepsClaimed;

        user.increaseAchievementPoints(achievementStep.getAchievementPoints());

        user.increaseMiningQueueSize(achievementStep.getMiningQueueReward());

        if (achievementStep.getMiningArea() != null)
        {
            user.addMiningArea(achievementStep.getMiningArea());
        }

        if (achievementStep.getRobotReward() > user.getRobotList().size())
        {
            user.addRobot();
        }

        List<AchievementPredecessor> achievementPredecessorList = achievement.getAchievementSuccessorList();

        for (AchievementPredecessor successor : achievementPredecessorList)
        {
            if (successor.getPredecessorStep() == stepsClaimed)
            {
                user.addUserAchievementIfApplicable(successor.getSuccessor());
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
        if (!(object instanceof UserAchievement))
        {
            return false;
        }
        UserAchievement other = (UserAchievement)object;
        return !((this.id == null && other.id != null) ||
                 (this.id != null && !this.id.equals(other.id)));
    }

    @Override
    public String toString()
    {
        return "nl.robominer.entity.UserAchievement[ id=" + id + " ]";
    }
}
