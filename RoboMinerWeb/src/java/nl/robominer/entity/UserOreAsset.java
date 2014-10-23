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
@Table(name = "UserOreAsset")
@XmlRootElement
@NamedQueries(
{
    @NamedQuery(name = "UserOreAsset.findAll",
                query = "SELECT u FROM UserOreAsset u"),
    @NamedQuery(name = "UserOreAsset.findByUsersId",
                query = "SELECT u FROM UserOreAsset u WHERE u.usersId = :usersId"),
    @NamedQuery(name = "UserOreAsset.findByUserAndOreId",
                query = "SELECT u FROM UserOreAsset u WHERE u.usersId = :usersId AND u.ore.id = :oreId")
})
public class UserOreAsset implements Serializable
{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    @Basic(optional = false)
    @NotNull
    @Column(name = "usersId")
    private int usersId;

    @ManyToOne
    @JoinColumn(name = "oreId")
    private Ore ore;

    @Basic(optional = false)
    @NotNull
    @Column(name = "amount")
    private int amount;

    public UserOreAsset()
    {
    }

    public UserOreAsset(int usersId, Ore ore)
    {
        this.usersId = usersId;
        this.ore = ore;
        this.amount = 0;
    }

    public int getUsersId()
    {
        return usersId;
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

    public void increaseAmount(int amount)
    {
        this.amount += amount;
    }

    public void decreaseAmount(int amount)
    {
        this.amount -= amount;
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
        if (!(object instanceof UserOreAsset))
        {
            return false;
        }

        UserOreAsset other = (UserOreAsset)object;
        return !((this.id == null && other.id != null) ||
                 (this.id != null && !this.id.equals(other.id)));
    }

    @Override
    public String toString()
    {
        return "nl.robominer.entity.UserOreAsset[ id=" + id + " ]";
    }
}
