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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Arnoud Jagerman
 */
@Entity
@Table(name = "MiningArea")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "MiningArea.findAll", query = "SELECT m FROM MiningArea m"),
    @NamedQuery(name = "MiningArea.findById", query = "SELECT m FROM MiningArea m WHERE m.id = :id")})
public class MiningArea implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "areaName")
    private String areaName;

    @ManyToOne
    @NotNull
    @JoinColumn(name = "orePriceId")
    private OrePrice orePrice;

    @Basic(optional = false)
    @NotNull
    @Column(name = "sizeX")
    private int sizeX;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "sizeY")
    private int sizeY;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "maxMoves")
    private int maxMoves;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "miningTime")
    private int miningTime;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "taxRate")
    private int taxRate;
    
    @ManyToOne
    @NotNull
    @JoinColumn(name = "aiRobotId")
    private Robot aiRobot;
    
    @OneToMany
    @JoinColumn(name = "MiningAreaOreSupply.miningAreaId")
    private List<MiningAreaOreSupply> miningAreaOreSupply;
    
    public MiningArea() {
    }

    public Integer getId() {
        return id;
    }

    public String getAreaName() {
        return areaName;
    }

    public OrePrice getOrePrice() {
        return orePrice;
    }
    
    public int getSizeX() {
        return sizeX;
    }

    public int getSizeY() {
        return sizeY;
    }

    public int getMaxMoves() {
        return maxMoves;
    }

    public int getMiningTime() {
        return miningTime;
    }

    public int getTaxRate() {
        return taxRate;
    }

    public Robot getAiRobot() {
        return aiRobot;
    }
    
    public List<MiningAreaOreSupply> getMiningAreaOreSupply() {
        return miningAreaOreSupply;
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
        if (!(object instanceof MiningArea)) {
            return false;
        }
        MiningArea other = (MiningArea) object;
        return (this.id != null || other.id == null) && (this.id == null || this.id.equals(other.id));
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.MiningArea[ id=" + id + " ]";
    }

}
