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
@Table(name = "MiningOreResult")
@XmlRootElement
@NamedQueries(
{
    @NamedQuery(name = "MiningOreResult.findAll", query = "SELECT m FROM MiningOreResult m"),
    @NamedQuery(name = "MiningOreResult.findByMiningQueueId",
                query = "SELECT m FROM MiningOreResult m WHERE m.miningQueue.id = :miningQueueId"),
    @NamedQuery(name = "MiningOreResult.findByOreId",
                query = "SELECT m FROM MiningOreResult m WHERE m.ore.id = :oreId"),
    @NamedQuery(name = "MiningOreResult.findByAmount",
                query = "SELECT m FROM MiningOreResult m WHERE m.amount = :amount")
})
public class MiningOreResult implements Serializable
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
    @Column(name = "amount")
    private int amount;

    @Basic(optional = true)
    @Column(name = "tax")
    private int tax;

    @ManyToOne
    @JoinColumn(name = "miningQueueId")
    private MiningQueue miningQueue;

    @ManyToOne
    @JoinColumn(name = "oreId")
    private Ore ore;

    public MiningOreResult()
    {
    }

    public Integer getId()
    {
        return id;
    }

    public MiningQueue getMiningQueue()
    {
        return miningQueue;
    }

    public Ore getOre()
    {
        return ore;
    }

    public int getAmount()
    {
        return amount;
    }

    public void setAmount(int amount)
    {
        this.amount = amount;
    }

    public void calculateTax()
    {
        tax = (int)Math.floor(amount * miningQueue.getMiningArea().getTaxRate() / 100);
    }

    public int getTax()
    {
        return tax;
    }

    public int getReward()
    {
        return amount - tax;
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
        if (!(object instanceof MiningOreResult))
        {
            return false;
        }

        MiningOreResult other = (MiningOreResult)object;

        return (this.id != null && other.id != null && this.id.equals(other.id));
    }

    @Override
    public String toString()
    {
        return "nl.robominer.entity.MiningOreResult[ id=" + id + " ]";
    }
}
