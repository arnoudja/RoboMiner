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
@Table(name = "OrePriceAmount")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "OrePriceAmount.findAll", query = "SELECT o FROM OrePriceAmount o"),
    @NamedQuery(name = "OrePriceAmount.findById", query = "SELECT o FROM OrePriceAmount o WHERE o.id = :id"),
    @NamedQuery(name = "OrePriceAmount.findByOrePriceId", query = "SELECT o FROM OrePriceAmount o WHERE o.orePriceId = :orePriceId")})
public class OrePriceAmount implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "orePriceId")
    private int orePriceId;
    
    @ManyToOne
    @JoinColumn(name = "oreId", insertable = false, updatable = false)
    private Ore ore;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "amount")
    private int amount;

    public OrePriceAmount() {
    }

    public Integer getId() {
        return id;
    }

    public int getOrePriceId() {
        return orePriceId;
    }

    public Ore getOre() {
        return ore;
    }

    public int getAmount() {
        return amount;
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
        if (!(object instanceof OrePriceAmount)) {
            return false;
        }
        OrePriceAmount other = (OrePriceAmount) object;
        return (this.id != null || other.id == null) && (this.id == null || this.id.equals(other.id));
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.OrePriceAmount[ id=" + id + " ]";
    }
    
}
