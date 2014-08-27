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
import javax.persistence.MapKey;
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
@Table(name = "Users")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Users.findAll", query = "SELECT u FROM Users u"),
    @NamedQuery(name = "Users.findById", query = "SELECT u FROM Users u WHERE u.id = :id"),
    @NamedQuery(name = "Users.findByUsername", query = "SELECT u FROM Users u WHERE u.username = :username"),
    @NamedQuery(name = "Users.findByEmail", query = "SELECT u FROM Users u WHERE u.email = :email"),
    @NamedQuery(name = "Users.findByUsernameOrEmail", query = "SELECT u FROM Users u WHERE u.username = :name OR u.email = :name")})
public class Users implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "username")
    private String username;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "email")
    private String email;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "password")
    private String password;

    @OneToMany
    @JoinColumn(name = "UserOreAsset.usersId")
    @MapKey(name="oreId")
    private Map<Integer, UserOreAsset> userOreAssets;

    @OneToMany
    @JoinColumn(name = "UserRobotPartAsset.usersId")
    @MapKey(name="robotPartId")
    private Map<Integer, UserRobotPartAsset> userRobotPartAssets;

    public Users() {
    }

    public Integer getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Map<Integer, UserOreAsset> getUserOreAssets() {
        return userOreAssets;
    }
    
    public int getUserOreAmount(int oreId) {
        UserOreAsset asset = userOreAssets.get(oreId);
        return asset == null ? 0 : asset.getAmount();
    }
    
    public Map<Integer, UserRobotPartAsset> getUserRobotPartAssets() {
        return userRobotPartAssets;
    }
    
    public int getTotalRobotPartAmount(int robotPartId) {
        UserRobotPartAsset asset = userRobotPartAssets.get(robotPartId);
        return asset == null ? 0 : asset.getTotalOwned();
    }
    
    public int getUnassignedRobotPartAmount(int robotPartId) {
        UserRobotPartAsset asset = userRobotPartAssets.get(robotPartId);
        return asset == null ? 0 : asset.getUnassigned();
    }
    
    public boolean canAffort(OrePrice orePrice) {
        
        boolean result = true;
        
        List<OrePriceAmount> orePriceAmountList = orePrice.getOrePriceAmountList();
        for (OrePriceAmount orePriceAmount : orePriceAmountList) {
            if (orePriceAmount.getAmount() > getUserOreAmount(orePriceAmount.getOre().getId())) {
                result = false;
            }
        }
        
        return result;
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
        if (!(object instanceof Users)) {
            return false;
        }
        Users other = (Users) object;
        return (this.id != null || other.id == null) && (this.id == null || this.id.equals(other.id));
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.Users[ id=" + id + " ]";
    }
    
}
