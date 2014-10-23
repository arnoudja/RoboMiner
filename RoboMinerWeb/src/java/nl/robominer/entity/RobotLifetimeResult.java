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
@Table(name = "RobotLifetimeResult")
@XmlRootElement
@NamedQueries(
{
    @NamedQuery(name = "RobotLifetimeResult.findAll",
                query = "SELECT r FROM RobotLifetimeResult r"),
    @NamedQuery(name = "RobotLifetimeResult.findByRobotId",
                query = "SELECT r FROM RobotLifetimeResult r WHERE r.robotId = :robotId"),
    @NamedQuery(name = "RobotLifetimeResult.findByRobotAndOreId",
                query = "SELECT r FROM RobotLifetimeResult r WHERE r.robotId = :robotId AND r.ore.id = :oreId")
})
public class RobotLifetimeResult implements Serializable
{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    @Basic(optional = false)
    @NotNull
    @Column(name = "robotId")
    private int robotId;

    @ManyToOne
    @JoinColumn(name = "oreId")
    private Ore ore;

    @Basic(optional = false)
    @NotNull
    @Column(name = "amount")
    private int amount;

    @Basic(optional = false)
    @NotNull
    @Column(name = "tax")
    private int tax;

    public RobotLifetimeResult()
    {
    }

    public RobotLifetimeResult(int robotId, Ore ore)
    {
        this.robotId = robotId;
        this.ore     = ore;
        this.amount  = 0;
        this.tax     = 0;
    }

    public RobotLifetimeResult(int robotId, Ore ore, int amount, int tax)
    {
        this.robotId = robotId;
        this.ore     = ore;
        this.amount  = amount;
        this.tax     = tax;
    }

    public Integer getId()
    {
        return id;
    }

    public int getRobotId()
    {
        return robotId;
    }

    public Ore getOre()
    {
        return ore;
    }

    public Integer getOreId()
    {
        return ore.getId();
    }

    public int getAmount()
    {
        return amount;
    }

    public void increaseAmount(int amount)
    {
        this.amount += amount;
    }

    public int getTax()
    {
        return tax;
    }

    public void increaseTax(int tax)
    {
        this.tax += tax;
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
        if (!(object instanceof RobotLifetimeResult))
        {
            return false;
        }

        RobotLifetimeResult other = (RobotLifetimeResult)object;
        return !((this.id == null && other.id != null) ||
                 (this.id != null && !this.id.equals(other.id)));
    }

    @Override
    public String toString()
    {
        return "nl.robominer.entity.RobotLifetimeResult[ id=" + id + " ]";
    }
}
