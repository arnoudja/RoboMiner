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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Arnoud Jagerman
 */
@Entity
@Table(name = "RobotPart")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RobotPart.findAll", query = "SELECT r FROM RobotPart r"),
    @NamedQuery(name = "RobotPart.findById", query = "SELECT r FROM RobotPart r WHERE r.id = :id"),
    @NamedQuery(name = "RobotPart.findByTypeId", query = "SELECT r FROM RobotPart r WHERE r.robotPartType.id = :typeId")})
public class RobotPart implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    @ManyToOne
    @NotNull
    @JoinColumn(name = "typeId")
    private RobotPartType robotPartType;

    @Basic(optional = false)
    @NotNull
    @Column(name = "tierId")
    private int tierId;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "partName")
    private String partName;

    @ManyToOne
    @NotNull
    @JoinColumn(name = "orePriceId")
    private OrePrice orePrice;

    @Basic(optional = false)
    @NotNull
    @Column(name = "oreCapacity")
    private int oreCapacity;

    @Basic(optional = false)
    @NotNull
    @Column(name = "miningCapacity")
    private int miningCapacity;

    @Basic(optional = false)
    @NotNull
    @Column(name = "batteryCapacity")
    private int batteryCapacity;

    @Basic(optional = false)
    @NotNull
    @Column(name = "memoryCapacity")
    private int memoryCapacity;

    @Basic(optional = false)
    @NotNull
    @Column(name = "cpuCapacity")
    private int cpuCapacity;

    @Basic(optional = false)
    @NotNull
    @Column(name = "forwardCapacity")
    private int forwardCapacity;

    @Basic(optional = false)
    @NotNull
    @Column(name = "backwardCapacity")
    private int backwardCapacity;

    @Basic(optional = false)
    @NotNull
    @Column(name = "rotateCapacity")
    private int rotateCapacity;

    @Basic(optional = false)
    @NotNull
    @Column(name = "rechargeTime")
    private int rechargeTime;

    @Basic(optional = false)
    @NotNull
    @Column(name = "weight")
    private int weight;

    @Basic(optional = false)
    @NotNull
    @Column(name = "volume")
    private int volume;

    @Basic(optional = false)
    @NotNull
    @Column(name = "powerUsage")
    private int powerUsage;

    @ManyToOne
    @JoinColumn(name = "tierId", insertable = false, updatable = false)
    private Tier tier;

    public RobotPart() {
    }

    public Integer getId() {
        return id;
    }

    public RobotPartType getRobotPartType() {
        return robotPartType;
    }

    public int getTierId() {
        return tierId;
    }
    
    public String getPartName() {
        return partName;
    }

    public OrePrice getOrePrice() {
        return orePrice;
    }
    
    public int getOreCapacity() {
        return oreCapacity;
    }

    public int getMiningCapacity() {
        return miningCapacity;
    }
    
    public int getBatteryCapacity() {
        return batteryCapacity;
    }
    
    public int getMemoryCapacity() {
        return memoryCapacity;
    }
    
    public int getCpuCapacity() {
        return cpuCapacity;
    }
    
    public int getForwardCapacity() {
        return forwardCapacity;
    }
    
    public int getBackwardCapacity() {
        return backwardCapacity;
    }
    
    public int getRotateCapacity() {
        return rotateCapacity;
    }
    
    public int getRechargeTime() {
        return rechargeTime;
    }
    
    public int getWeight() {
        return weight;
    }
    
    public int getVolume() {
        return volume;
    }
    
    public int getPowerUsage() {
        return powerUsage;
    }

    public Tier getTier() {
        return tier;
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
        if (!(object instanceof RobotPart)) {
            return false;
        }
        RobotPart other = (RobotPart) object;
        return (this.id != null || other.id == null) && (this.id == null || this.id.equals(other.id));
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.RobotPart[ id=" + id + " ]";
    }
    
}
