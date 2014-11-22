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
@Table(name = "MiningAreaLifetimeResult")
@XmlRootElement
@NamedQueries(
{
    @NamedQuery(name = "MiningAreaLifetimeResult.findAll", query = "SELECT m FROM MiningAreaLifetimeResult m"),
    @NamedQuery(name = "MiningAreaLifetimeResult.findByMiningAreaId",
                query = "SELECT m FROM MiningAreaLifetimeResult m WHERE m.miningAreaId = :miningAreaId"),
    @NamedQuery(name = "MiningAreaLifetimeResult.findByPK",
                query = "SELECT m FROM MiningAreaLifetimeResult m WHERE m.miningAreaId = :miningAreaId AND m.ore.id = :oreId")
})
public class MiningAreaLifetimeResult implements Serializable
{
    private static final long serialVersionUID = 1L;

    /**
     * The primary key value.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    @Basic(optional = false)
    @NotNull
    @Column(name = "miningAreaId")
    private int miningAreaId;

    @Basic(optional = false)
    @NotNull
    @Column(name = "totalAmount")
    private long totalAmount;

    @Basic(optional = false)
    @NotNull
    @Column(name = "totalContainerSize")
    private long totalContainerSize;

    @ManyToOne
    @JoinColumn(name = "oreId")
    private Ore ore;

    public MiningAreaLifetimeResult()
    {
    }

    public MiningAreaLifetimeResult(int miningAreaId, Ore ore, int amount, int containerSize)
    {
        this.miningAreaId       = miningAreaId;
        this.ore                = ore;
        this.totalAmount        = amount;
        this.totalContainerSize = containerSize;
    }

    public Integer getId()
    {
        return id;
    }

    public int getMiningAreaId()
    {
        return miningAreaId;
    }

    public long getTotalAmount()
    {
        return totalAmount;
    }

    public void increaseTotalAmount(int amount)
    {
        this.totalAmount += amount;
    }

    public long getTotalContainerSize()
    {
        return totalContainerSize;
    }

    public void increaseTotalContainerSize(int containerSize)
    {
        this.totalContainerSize += containerSize;
    }

    public Ore getOre()
    {
        return ore;
    }

    public double getPercentage()
    {
        return (totalContainerSize > 0 ? (totalAmount * 100.0 / totalContainerSize) : .0);
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
        if (!(object instanceof MiningAreaLifetimeResult))
        {
            return false;
        }

        MiningAreaLifetimeResult other = (MiningAreaLifetimeResult)object;

        return (this.id != null && other.id != null && this.id.equals(other.id));
    }

    @Override
    public String toString()
    {
        return "nl.robominer.entity.MiningAreaLifetimeResult[ id=" + id + " ]";
    }
}
