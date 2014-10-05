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
import java.util.Date;
import java.util.List;
import java.util.Objects;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Arnoud Jagerman
 */
@Entity
@Table(name = "MiningQueue")
@XmlRootElement
@NamedQueries(
{
    @NamedQuery(name = "MiningQueue.findAll",
                query = "SELECT m FROM MiningQueue m"),
    @NamedQuery(name = "MiningQueue.findById",
                query = "SELECT m FROM MiningQueue m WHERE m.id = :id"),
    @NamedQuery(name = "MiningQueue.findWaitingByUsersId",
                query = "SELECT m FROM MiningQueue m WHERE (m.miningEndTime IS NULL OR m.miningEndTime > CURRENT_TIMESTAMP) AND m.robot.user.id = :usersId ORDER BY m.creationTime"),
    @NamedQuery(name = "MiningQueue.findWaitingByRobotId",
                query = "SELECT m FROM MiningQueue m WHERE (m.miningEndTime IS NULL OR m.miningEndTime > CURRENT_TIMESTAMP) AND m.robot.id = :robotId ORDER BY m.creationTime"),
    @NamedQuery(name = "MiningQueue.findResultsByRobotId",
                query = "SELECT m FROM MiningQueue m WHERE m.claimed = true AND m.robot.id = :robotId ORDER BY m.creationTime DESC"),
    @NamedQuery(name = "MiningQueue.findClaimableByUsersId",
                query = "SELECT m FROM MiningQueue m WHERE m.miningEndTime IS NOT NULL AND m.miningEndTime < CURRENT_TIMESTAMP AND m.robot.user.id = :usersId and m.claimed = false"),
    @NamedQuery(name = "MiningQueue.findByRallyAndUsersId",
                query = "SELECT m FROM MiningQueue m WHERE m.claimed = true AND m.rallyResult.id = :rallyResultId AND m.robot.user.id = :usersId")
})
public class MiningQueue implements Serializable
{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    @ManyToOne
    @NotNull
    @JoinColumn(name = "miningAreaId")
    private MiningArea miningArea;

    @ManyToOne
    @NotNull
    @JoinColumn(name = "robotId")
    private Robot robot;

    @ManyToOne
    @JoinColumn(name = "rallyResultId")
    private RallyResult rallyResult;

    @Basic(optional = true)
    @Column(name = "playerNumber")
    private int playerNumber;

    @Basic(optional = true)
    @Column(name = "creationTime", insertable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date creationTime;

    @Column(name = "miningEndTime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date miningEndTime;

    @Basic(optional = false)
    @NotNull
    @Column(name = "claimed")
    private boolean claimed;

    @OneToMany
    @JoinColumn(name = "MiningOreResult.miningQueueId")
    private List<MiningOreResult> miningOreResults;

    @OneToMany
    @JoinColumn(name = "RobotActionsDone.miningQueueId")
    private List<RobotActionsDone> robotActionsDoneList;

    public MiningQueue()
    {
    }

    public Integer getId()
    {
        return id;
    }

    public MiningArea getMiningArea()
    {
        return miningArea;
    }

    public void setMiningArea(MiningArea miningArea)
    {
        this.miningArea = miningArea;
    }

    public Robot getRobot()
    {
        return robot;
    }

    public void setRobot(Robot robot)
    {
        this.robot = robot;
    }

    public RallyResult getRallyResult()
    {
        return rallyResult;
    }

    public int getPlayerNumber()
    {
        return playerNumber;
    }

    public Date getCreationTime()
    {
        return creationTime;
    }

    public Date getMiningEndTime()
    {
        return miningEndTime;
    }

    public boolean getClaimed()
    {
        return claimed;
    }

    public void setClaimed(boolean claimed)
    {
        this.claimed = claimed;
    }

    public List<MiningOreResult> getMiningOreResults()
    {
        return miningOreResults;
    }

    public List<RobotActionsDone> getRobotActionsDoneList()
    {
        return robotActionsDoneList;
    }

    public int getTotalOreMined()
    {
        int result = 0;

        for (MiningOreResult miningOreResult : miningOreResults)
        {
            result += miningOreResult.getAmount();
        }

        return result;
    }

    public int getTotalTax()
    {
        int result = 0;

        for (MiningOreResult miningOreResult : miningOreResults)
        {
            result += miningOreResult.getTax();
        }

        return result;
    }

    public int getTotalReward()
    {
        int result = 0;

        for (MiningOreResult miningOreResult : miningOreResults)
        {
            result += miningOreResult.getReward();
        }

        return result;
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
        if (!(object instanceof MiningQueue))
        {
            return false;
        }

        MiningQueue other = (MiningQueue)object;
        return Objects.equals(this.id, other.id);
    }

    @Override
    public String toString()
    {
        return "nl.robominer.entity.MiningQueue[ id=" + id + " ]";
    }
}
