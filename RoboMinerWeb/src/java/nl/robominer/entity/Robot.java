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
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
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
 *
 * @author Arnoud Jagerman
 */
@Entity
@Table(name = "Robot")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Robot.findAll", query = "SELECT r FROM Robot r"),
    @NamedQuery(name = "Robot.findById", query = "SELECT r FROM Robot r WHERE r.id = :id"),
    @NamedQuery(name = "Robot.findByIdAndUser", query = "SELECT r FROM Robot r WHERE r.id = :id AND r.user.id = :usersId"),
    @NamedQuery(name = "Robot.findByUsersId", query = "SELECT r FROM Robot r WHERE r.user.id = :usersId")})
public class Robot implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    
    @ManyToOne
    @NotNull
    @JoinColumn(name = "usersId")
    private Users user;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "robotName")
    private String robotName;

    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 65535)
    @Column(name = "sourceCode")
    private String sourceCode;

    @Column(name = "programSourceId")
    private Integer programSourceId;

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
    private int robotSize;
    
    @Column(name = "rechargeEndTime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date rechargeEndTime;

    @Column(name = "miningEndTime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date miningEndTime;

    public Robot() {
    }

    public Integer getId() {
        return id;
    }

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    public String getRobotName() {
        return robotName;
    }

    public void setRobotName(String robotName) {
        this.robotName = robotName;
    }

    public String getSourceCode() {
        return sourceCode;
    }
    
    public void setSourceCode(String sourceCode) {
        this.sourceCode = sourceCode;
    }
    
    public Integer getProgramSourceId() {
        return programSourceId;
    }

    public void setProgramSourceId(Integer programSourceId) {
        this.programSourceId = programSourceId;
    }

    public RobotPart getOreContainer() {
        return oreContainer;
    }
    
    public void setOreContainer(RobotPart oreContainer) {
        this.oreContainer = oreContainer;
    }

    public RobotPart getMiningUnit() {
        return miningUnit;
    }
    
    public void setMiningUnit(RobotPart miningUnit) {
        this.miningUnit = miningUnit;
    }

    public RobotPart getBattery() {
        return battery;
    }
    
    public void setBattery(RobotPart battery) {
        this.battery = battery;
    }

    public RobotPart getMemoryModule() {
        return memoryModule;
    }
    
    public void setMemoryModule(RobotPart memoryModule) {
        this.memoryModule = memoryModule;
    }

    public RobotPart getCpu() {
        return cpu;
    }
    
    public void setCpu(RobotPart cpu) {
        this.cpu = cpu;
    }

    public RobotPart getEngine() {
        return engine;
    }
    
    public void setEngine(RobotPart engine) {
        this.engine = engine;
    }
    
    public int getRechargeTime() {
        return rechargeTime;
    }

    public void setRechargeTime(int rechargeTime) {
        this.rechargeTime = rechargeTime;
    }

    public int getMaxOre() {
        return maxOre;
    }

    public void setMaxOre(int maxOre) {
        this.maxOre = maxOre;
    }

    public int getMiningSpeed() {
        return miningSpeed;
    }

    public void setMiningSpeed(int miningSpeed) {
        this.miningSpeed = miningSpeed;
    }

    public int getMaxTurns() {
        return maxTurns;
    }

    public void setMaxTurns(int maxTurns) {
        this.maxTurns = maxTurns;
    }

    public int getMemorySize() {
        return memorySize;
    }

    public void setMemorySize(int memorySize) {
        this.memorySize = memorySize;
    }

    public int getCpuSpeed() {
        return cpuSpeed;
    }

    public void setCpuSpeed(int cpuSpeed) {
        this.cpuSpeed = cpuSpeed;
    }

    public double getForwardSpeed() {
        return forwardSpeed;
    }

    public void setForwardSpeed(double forwardSpeed) {
        this.forwardSpeed = forwardSpeed;
    }

    public double getBackwardSpeed() {
        return backwardSpeed;
    }

    public void setBackwardSpeed(double backwardSpeed) {
        this.backwardSpeed = backwardSpeed;
    }

    public int getRotateSpeed() {
        return rotateSpeed;
    }

    public void setRotateSpeed(int rotateSpeed) {
        this.rotateSpeed = rotateSpeed;
    }

    public int getRobotSize() {
        return robotSize;
    }

    public void setRobotSize(int robotSize) {
        this.robotSize = robotSize;
    }

    public Date getRechargeEndTime() {
        return rechargeEndTime;
    }

    public void setRechargeEndTime(Date rechargeEndTime) {
        this.rechargeEndTime = rechargeEndTime;
    }
    
    public Date getMiningEndTime() {
        return miningEndTime;
    }

    public void setMiningEndTime(Date miningEndTime) {
        this.miningEndTime = miningEndTime;
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
        if (!(object instanceof Robot)) {
            return false;
        }
        Robot other = (Robot) object;
        return (this.id != null || other.id == null) && (this.id == null || this.id.equals(other.id));
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.Robot[ id=" + id + " ]";
    }
    
    public void fillDefaults(RobotPart oreContainer, RobotPart miningUnit, RobotPart battery,
                             RobotPart memoryModule, RobotPart cpu, RobotPart engine) {
        
        setRobotName("NewRobot");
        setSourceCode("move(1);\nmine();");
        setOreContainer(oreContainer);
        setMiningUnit(miningUnit);
        setBattery(battery);
        setMemoryModule(memoryModule);
        setCpu(cpu);
        setEngine(engine);
        
        updateParameters();
    }

    public void updateParameters() {
        
        int batteryCapacity = oreContainer.getBatteryCapacity() + miningUnit.getBatteryCapacity() + 
                              battery.getBatteryCapacity() + memoryModule.getBatteryCapacity() + 
                              cpu.getBatteryCapacity() + engine.getBatteryCapacity();
        
        int powerUsage = oreContainer.getPowerUsage() + miningUnit.getPowerUsage() + 
                         battery.getPowerUsage() + memoryModule.getPowerUsage() + 
                         cpu.getPowerUsage() + engine.getPowerUsage();
        
        double weight = oreContainer.getWeight() + miningUnit.getWeight() + 
                        battery.getWeight() + memoryModule.getWeight() + 
                        cpu.getWeight() + engine.getWeight();
        
        int volume = oreContainer.getVolume() + miningUnit.getVolume() + 
                     battery.getVolume() + memoryModule.getVolume() + 
                     cpu.getVolume() + engine.getVolume();
        
        double forwardCapacity = oreContainer.getForwardCapacity() + miningUnit.getForwardCapacity() + 
                                 battery.getForwardCapacity() + memoryModule.getForwardCapacity() + 
                                 cpu.getForwardCapacity() + engine.getForwardCapacity();
        
        double backwardCapacity = oreContainer.getBackwardCapacity() + miningUnit.getBackwardCapacity() + 
                                  battery.getBackwardCapacity() + memoryModule.getBackwardCapacity() + 
                                  cpu.getBackwardCapacity() + engine.getBackwardCapacity();
        
        int rotateCapacity = oreContainer.getRotateCapacity() + miningUnit.getRotateCapacity() + 
                             battery.getRotateCapacity() + memoryModule.getRotateCapacity() + 
                             cpu.getRotateCapacity() + engine.getRotateCapacity();
        
        setRechargeTime(oreContainer.getRechargeTime() + miningUnit.getRechargeTime() + 
                        battery.getRechargeTime() + memoryModule.getRechargeTime() + 
                        cpu.getRechargeTime() + engine.getRechargeTime());
        
        setMaxOre(oreContainer.getOreCapacity() + miningUnit.getOreCapacity() +
                  battery.getOreCapacity() + memoryModule.getOreCapacity() +
                  cpu.getOreCapacity() + engine.getOreCapacity());

        setMiningSpeed(oreContainer.getMiningCapacity() + miningUnit.getMiningCapacity() + 
                       battery.getMiningCapacity() + memoryModule.getMiningCapacity() + 
                       cpu.getMiningCapacity() + engine.getMiningCapacity());
        
        setMemorySize(oreContainer.getMemoryCapacity() + miningUnit.getMemoryCapacity() + 
                      battery.getMemoryCapacity() + memoryModule.getMemoryCapacity() + 
                      cpu.getMemoryCapacity() + engine.getMemoryCapacity());
        
        setCpuSpeed(oreContainer.getCpuCapacity() + miningUnit.getCpuCapacity() + 
                    battery.getCpuCapacity() + memoryModule.getCpuCapacity() + 
                    cpu.getCpuCapacity() + engine.getCpuCapacity());
        
        setMaxTurns(batteryCapacity / powerUsage);
        
        setForwardSpeed(forwardCapacity / weight);
        setBackwardSpeed(backwardCapacity / weight);
        setRotateSpeed((int)(10 * rotateCapacity / weight));

        setRobotSize((int) Math.pow(volume, 0.33));
    }
}
