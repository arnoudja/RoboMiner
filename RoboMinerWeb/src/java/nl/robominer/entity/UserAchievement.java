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
 * Entity class for user achievement progress information.
 *
 * @author Arnoud Jagerman
 */
@Entity
@Table(name = "UserAchievement")
@XmlRootElement
@NamedQueries(
{
    @NamedQuery(name = "UserAchievement.findByUsersId",
                query = "SELECT u FROM UserAchievement u WHERE u.user.id = :usersId")
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

    /**
     * Retrieve the user this achievement progress belongs to.
     * @return The user this achievement progress belongs to.
     */
    public Users getUser()
    {
        return user;
    }

    /**
     * Retrieve the achievement belonging to this progress.
     *
     * @return The achievement belonging to this progress.
     */
    public Achievement getAchievement()
    {
        return achievement;
    }

    /**
     * Retrieve the number of achievement steps already completed.
     *
     * @return The number of achievement steps already completed.
     */
    public int getStepsClaimed()
    {
        return stepsClaimed;
    }

    /**
     * Retrieve the number of achievement points earned so far.
     *
     * @return The number of achievement points earned so far.
     */
    public int getAchievementPointsEarned()
    {
        int total = 0;

        for (int i = 1; i <= stepsClaimed; ++i)
        {
            total += achievement.getAchievementStep(i).getAchievementPoints();
        }

        return total;
    }

    /**
     * Check whether the next step is claimable.
     *
     * @return true if all requirements for the next step are met, false if
     * not all requirements are met or there is no next step.
     */
    public boolean isClaimable()
    {
        AchievementStep achievementStep = achievement.getAchievementStep(stepsClaimed + 1);

        return (achievementStep != null && achievementStep.isAchievedByUser(user));
    }

    /**
     * Claim the next achievement step.
     *
     * @return true if the next achievement step is claimed successfully, false
     * if not all requirements are met or there is no next step.
     */
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
