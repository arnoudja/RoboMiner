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
@Table(name = "UserRobotPartAsset")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "UserRobotPartAsset.findAll", query = "SELECT u FROM UserRobotPartAsset u"),
    @NamedQuery(name = "UserRobotPartAsset.findByUsersId", query = "SELECT u FROM UserRobotPartAsset u WHERE u.userRobotPartAssetPK.usersId = :usersId"),
    @NamedQuery(name = "UserRobotPartAsset.findByUsersIdAndPartType", query = "SELECT u FROM UserRobotPartAsset u WHERE u.userRobotPartAssetPK.usersId = :usersId AND u.robotPart.robotPartType.id = :robotPartTypeId"),
    @NamedQuery(name = "UserRobotPartAsset.findByRobotPartId", query = "SELECT u FROM UserRobotPartAsset u WHERE u.userRobotPartAssetPK.robotPartId = :robotPartId"),
    @NamedQuery(name = "UserRobotPartAsset.findByUsersIdAndRobotPartId", query = "SELECT u FROM UserRobotPartAsset u WHERE u.userRobotPartAssetPK.usersId = :usersId AND u.userRobotPartAssetPK.robotPartId = :robotPartId")})
public class UserRobotPartAsset implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @EmbeddedId
    protected UserRobotPartAssetPK userRobotPartAssetPK;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "amount")
    private int amount;

    @Column(name = "robotPartId", insertable = false, updatable = false)
    private int robotPartId;
    
    @ManyToOne
    @JoinColumn(name = "robotPartId", insertable = false, updatable = false)
    private RobotPart robotPart;

    public UserRobotPartAsset() {
    }

    public UserRobotPartAsset(int usersId, int robotPartId, int amount) {
        this.userRobotPartAssetPK = new UserRobotPartAssetPK(usersId, robotPartId);
        this.amount = amount;
    }

    public UserRobotPartAssetPK getUserRobotPartAssetPK() {
        return userRobotPartAssetPK;
    }

    public void setUserRobotPartAssetPK(UserRobotPartAssetPK userRobotPartAssetPK) {
        this.userRobotPartAssetPK = userRobotPartAssetPK;
    }

    public RobotPart getRobotPart() {
        return robotPart;
    }
    
    public int getRobotPartId() {
        return robotPartId;
    }
    
    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public void removeOne() throws IllegalStateException{
        
        if (amount <= 0) {
            throw new IllegalStateException();
        }
        
        amount--;
    }
    
    public void addOne() {
        amount++;
    }
    
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (userRobotPartAssetPK != null ? userRobotPartAssetPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof UserRobotPartAsset)) {
            return false;
        }
        UserRobotPartAsset other = (UserRobotPartAsset) object;
        return (this.userRobotPartAssetPK != null || other.userRobotPartAssetPK == null) && (this.userRobotPartAssetPK == null || this.userRobotPartAssetPK.equals(other.userRobotPartAssetPK));
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.UserRobotPartAsset[ userRobotPartAssetPK=" + userRobotPartAssetPK + " ]";
    }
    
}
