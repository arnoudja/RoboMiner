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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Arnoud Jagerman
 */
@Entity
@Table(name = "MiningAreaOreSupply")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "MiningAreaOreSupply.findAll", query = "SELECT m FROM MiningAreaOreSupply m"),
    @NamedQuery(name = "MiningAreaOreSupply.findById", query = "SELECT m FROM MiningAreaOreSupply m WHERE m.id = :id"),
    @NamedQuery(name = "MiningAreaOreSupply.findByMiningAreaId", query = "SELECT m FROM MiningAreaOreSupply m WHERE m.miningAreaId = :miningAreaId")})
public class MiningAreaOreSupply implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "miningAreaId")
    private int miningAreaId;
    
    @ManyToOne
    @NotNull
    @JoinColumn(name = "oreId")
    private Ore ore;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "supply")
    private int supply;

    @Basic(optional = false)
    @NotNull
    @Column(name = "radius")
    private int radius;

    public MiningAreaOreSupply() {
    }

    public MiningAreaOreSupply(Integer id) {
        this.id = id;
    }

    public MiningAreaOreSupply(Integer id, int miningAreaId, Ore ore, int supply) {
        this.id = id;
        this.miningAreaId = miningAreaId;
        this.ore = ore;
        this.supply = supply;
    }

    public Integer getId() {
        return id;
    }

    public int getMiningAreaId() {
        return miningAreaId;
    }

    public Ore getOre() {
        return ore;
    }

    public int getSupply() {
        return supply;
    }

    public int getRadius() {
        return radius;
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
        if (!(object instanceof MiningAreaOreSupply)) {
            return false;
        }
        MiningAreaOreSupply other = (MiningAreaOreSupply) object;
        return (this.id != null || other.id == null) && (this.id == null || this.id.equals(other.id));
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.MiningAreaOreSupply[ id=" + id + " ]";
    }
    
}
