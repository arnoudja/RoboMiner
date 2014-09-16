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
public class UserAchievementPK implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "usersId")
    private int usersId;

    @Basic(optional = false)
    @NotNull
    @Column(name = "achievementId")
    private int achievementId;

    public UserAchievementPK() {
    }

    public UserAchievementPK(int usersId, int achievementId) {
        this.usersId = usersId;
        this.achievementId = achievementId;
    }

    public int getUsersId() {
        return usersId;
    }

    public int getAchievementId() {
        return achievementId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) usersId;
        hash += (int) achievementId;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof UserAchievementPK)) {
            return false;
        }
        UserAchievementPK other = (UserAchievementPK) object;
        if (this.usersId != other.usersId) {
            return false;
        }
        return this.achievementId == other.achievementId;
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.UserAchievementPK[ usersId=" + usersId + ", achievementId=" + achievementId + " ]";
    }

}
