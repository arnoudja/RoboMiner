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
@Table(name = "UserAchievement")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "UserAchievement.findAll", query = "SELECT u FROM UserAchievement u"),
    @NamedQuery(name = "UserAchievement.findByUsersId", query = "SELECT u FROM UserAchievement u WHERE u.userAchievementPK.usersId = :usersId"),
    @NamedQuery(name = "UserAchievement.findByUsersAndAchievementId", query = "SELECT u FROM UserAchievement u WHERE u.userAchievementPK.usersId = :usersId AND u.userAchievementPK.achievementId = :achievementId"),
    @NamedQuery(name = "UserAchievement.findUnclaimedByUsersId", query = "SELECT u FROM UserAchievement u WHERE u.userAchievementPK.usersId = :usersId AND u.claimed = false")})
public class UserAchievement implements Serializable {

    private static final long serialVersionUID = 1L;

    @EmbeddedId
    protected UserAchievementPK userAchievementPK;

    @Basic(optional = false)
    @NotNull
    @Column(name = "claimed")
    private boolean claimed;

    @ManyToOne
    @JoinColumn(name = "achievementId", insertable = false, updatable = false)
    private Achievement achievement;

    public UserAchievement() {
    }

    public UserAchievement(int usersId, int achievementId) {
        this.userAchievementPK = new UserAchievementPK(usersId, achievementId);
        this.claimed = false;
    }

    public UserAchievementPK getUserAchievementPK() {
        return userAchievementPK;
    }

    public boolean getClaimed() {
        return claimed;
    }

    public void setClaimed(boolean claimed) {
        this.claimed = claimed;
    }

    public Achievement getAchievement() {
        return achievement;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (userAchievementPK != null ? userAchievementPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof UserAchievement)) {
            return false;
        }
        UserAchievement other = (UserAchievement) object;
        return (this.userAchievementPK != null || other.userAchievementPK == null) &&
               (this.userAchievementPK == null || this.userAchievementPK.equals(other.userAchievementPK));
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.UserAchievement[ userAchievementPK=" + userAchievementPK + " ]";
    }

}
