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
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Entity class for the pending changes for a robot, which will be applied to
 * the robot by the C++ part of RoboMiner at the end of a mining session.
 *
 * @author Arnoud Jagerman
 */
@Entity
@Table(name = "PendingRobotChanges")
@XmlRootElement
@NamedQueries(
{
    @NamedQuery(name = "PendingRobotChanges.findAll",
                query = "SELECT p FROM PendingRobotChanges p"),
    @NamedQuery(name = "PendingRobotChanges.findCommittedByRobotId",
                query = "SELECT p FROM PendingRobotChanges p WHERE p.robotId = :robotId AND p.changesCommitTime <= CURRENT_TIMESTAMP")
})
public class PendingRobotChanges implements Serializable
{
    private static final long serialVersionUID = 1L;

    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "robotId")
    private int robotId;

    @Basic(optional = false)
    @NotNull
    @Column(name = "submitTime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date submitTime;

    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 65535)
    @Column(name = "sourceCode")
    private String sourceCode;

    @ManyToOne
    @NotNull
    @JoinColumn(name = "oreContainerId")
    private RobotPart oreContainer;
    
    @ManyToOne
    @NotNull
    @JoinColumn(name = "miningUnitId")
    private RobotPart miningUnit;

    @ManyToOne
    @NotNull
    @JoinColumn(name = "batteryId")
    private RobotPart battery;

    @ManyToOne
    @NotNull
    @JoinColumn(name = "memoryModuleId")
    private RobotPart memoryModule;

    @ManyToOne
    @NotNull
    @JoinColumn(name = "cpuId")
    private RobotPart cpu;

    @ManyToOne
    @NotNull
    @JoinColumn(name = "engineId")
    private RobotPart engine;

    @Column(name = "oldOreContainerId")
    private Integer oldOreContainerId;

    @Column(name = "oldMiningUnitId")
    private Integer oldMiningUnitId;

    @Column(name = "oldBatteryId")
    private Integer oldBatteryId;

    @Column(name = "oldMemoryModuleId")
    private Integer oldMemoryModuleId;

    @Column(name = "oldCpuId")
    private Integer oldCpuId;

    @Column(name = "oldEngineId")
    private Integer oldEngineId;

    @Basic(optional = false)
    @NotNull
    @Column(name = "rechargeTime")
    private int rechargeTime;

    @Basic(optional = false)
    @NotNull
    @Column(name = "maxOre")
    private int maxOre;

    @Basic(optional = false)
    @NotNull
    @Column(name = "miningSpeed")
    private int miningSpeed;

    @Basic(optional = false)
    @NotNull
    @Column(name = "maxTurns")
    private int maxTurns;

    @Basic(optional = false)
    @NotNull
    @Column(name = "memorySize")
    private int memorySize;

    @Basic(optional = false)
    @NotNull
    @Column(name = "cpuSpeed")
    private int cpuSpeed;

    @Basic(optional = false)
    @NotNull
    @Column(name = "forwardSpeed")
    private double forwardSpeed;

    @Basic(optional = false)
    @NotNull
    @Column(name = "backwardSpeed")
    private double backwardSpeed;

    @Basic(optional = false)
    @NotNull
    @Column(name = "rotateSpeed")
    private int rotateSpeed;

    @Basic(optional = false)
    @NotNull
    @Column(name = "robotSize")
    private double robotSize;

    @Column(name = "changesCommitTime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date changesCommitTime;

    public PendingRobotChanges()
    {
    }

    public PendingRobotChanges(Robot robot)
    {
        if (robot.getChangePending())
        {
            throw new IllegalStateException();
        }

        this.robotId = robot.getId();
        this.submitTime = new Date();
        this.sourceCode = robot.getSourceCode();
        this.oreContainer = robot.getOreContainer();
        this.miningUnit = robot.getMiningUnit();
        this.battery = robot.getBattery();
        this.memoryModule = robot.getMemoryModule();
        this.cpu = robot.getCpu();
        this.engine = robot.getEngine();
        this.oldOreContainerId = this.oreContainer.getId();
        this.oldMiningUnitId = this.miningUnit.getId();
        this.oldBatteryId = this.battery.getId();
        this.oldMemoryModuleId = this.memoryModule.getId();
        this.oldCpuId = this.cpu.getId();
        this.oldEngineId = this.engine.getId();
        this.rechargeTime = robot.getRechargeTime();
        this.maxOre = robot.getMaxOre();
        this.miningSpeed = robot.getMiningSpeed();
        this.maxTurns = robot.getMaxTurns();
        this.memorySize = robot.getMemorySize();
        this.cpuSpeed = robot.getCpuSpeed();
        this.forwardSpeed = robot.getForwardSpeed();
        this.backwardSpeed = robot.getBackwardSpeed();
        this.rotateSpeed = robot.getRotateSpeed();
        this.robotSize = robot.getRobotSize();
        this.changesCommitTime = null;
    }

    public int getRobotId()
    {
        return robotId;
    }

    public void setRobotId(int robotId)
    {
        this.robotId = robotId;
    }

    public Date getSubmitTime()
    {
        return submitTime;
    }

    public String getSourceCode()
    {
        return sourceCode;
    }

    public void setSourceCode(String sourceCode)
    {
        this.sourceCode = sourceCode;
    }

    public RobotPart getOreContainer()
    {
        return oreContainer;
    }

    public void setOreContainer(RobotPart oreContainer)
    {
        this.oreContainer = oreContainer;
    }

    public RobotPart getMiningUnit()
    {
        return miningUnit;
    }

    public void setMiningUnit(RobotPart miningUnit)
    {
        this.miningUnit = miningUnit;
    }

    public RobotPart getBattery()
    {
        return battery;
    }

    public void setBattery(RobotPart battery)
    {
        this.battery = battery;
    }

    public RobotPart getMemoryModule()
    {
        return memoryModule;
    }

    public void setMemoryModule(RobotPart memoryModule)
    {
        this.memoryModule = memoryModule;
    }

    public RobotPart getCpu()
    {
        return cpu;
    }

    public void setCpu(RobotPart cpu)
    {
        this.cpu = cpu;
    }

    public RobotPart getEngine()
    {
        return engine;
    }

    public void setEngine(RobotPart engine)
    {
        this.engine = engine;
    }

    public Integer getOldOreContainerId()
    {
        return oldOreContainerId;
    }

    public void setOldOreContainerId(Integer oldOreContainerId)
    {
        this.oldOreContainerId = oldOreContainerId;
    }

    public Integer getOldMiningUnitId()
    {
        return oldMiningUnitId;
    }

    public void setOldMiningUnitId(Integer oldMiningUnitId)
    {
        this.oldMiningUnitId = oldMiningUnitId;
    }

    public Integer getOldBatteryId()
    {
        return oldBatteryId;
    }

    public void setOldBatteryId(Integer oldBatteryId)
    {
        this.oldBatteryId = oldBatteryId;
    }

    public Integer getOldMemoryModuleId()
    {
        return oldMemoryModuleId;
    }

    public void setOldMemoryModuleId(Integer oldMemoryModuleId)
    {
        this.oldMemoryModuleId = oldMemoryModuleId;
    }

    public Integer getOldCpuId()
    {
        return oldCpuId;
    }

    public void setOldCpuId(Integer oldCpuId)
    {
        this.oldCpuId = oldCpuId;
    }

    public Integer getOldEngineId()
    {
        return oldEngineId;
    }

    public void setOldEngineId(Integer oldEngineId)
    {
        this.oldEngineId = oldEngineId;
    }

    public int getRechargeTime()
    {
        return rechargeTime;
    }

    public void setRechargeTime(int rechargeTime)
    {
        this.rechargeTime = rechargeTime;
    }

    public int getMaxOre()
    {
        return maxOre;
    }

    public void setMaxOre(int maxOre)
    {
        this.maxOre = maxOre;
    }

    public int getMiningSpeed()
    {
        return miningSpeed;
    }

    public void setMiningSpeed(int miningSpeed)
    {
        this.miningSpeed = miningSpeed;
    }

    public int getMaxTurns()
    {
        return maxTurns;
    }

    public void setMaxTurns(int maxTurns)
    {
        this.maxTurns = maxTurns;
    }

    public int getMemorySize()
    {
        return memorySize;
    }

    public void setMemorySize(int memorySize)
    {
        this.memorySize = memorySize;
    }

    public int getCpuSpeed()
    {
        return cpuSpeed;
    }

    public void setCpuSpeed(int cpuSpeed)
    {
        this.cpuSpeed = cpuSpeed;
    }

    public double getForwardSpeed()
    {
        return forwardSpeed;
    }

    public void setForwardSpeed(double forwardSpeed)
    {
        this.forwardSpeed = forwardSpeed;
    }

    public double getBackwardSpeed()
    {
        return backwardSpeed;
    }

    public void setBackwardSpeed(double backwardSpeed)
    {
        this.backwardSpeed = backwardSpeed;
    }

    public int getRotateSpeed()
    {
        return rotateSpeed;
    }

    public void setRotateSpeed(int rotateSpeed)
    {
        this.rotateSpeed = rotateSpeed;
    }

    public double getRobotSize()
    {
        return robotSize;
    }

    public void setRobotSize(double robotSize)
    {
        this.robotSize = robotSize;
    }

    public Date getChangesCommitTime()
    {
        return changesCommitTime;
    }

    public void setChangesCommitTime(Date changesCommitTime)
    {
        this.changesCommitTime = changesCommitTime;
    }

    @Override
    public int hashCode()
    {
        return robotId;
    }

    @Override
    public boolean equals(Object object)
    {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PendingRobotChanges))
        {
            return false;
        }

        PendingRobotChanges other = (PendingRobotChanges)object;

        return this.robotId == other.robotId;
    }

    @Override
    public String toString()
    {
        return "nl.robominer.entity.PendingRobotChanges[ robotId=" + robotId + " ]";
    }
}
