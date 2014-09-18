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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Entity class for the Robot data.
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
    @NamedQuery(name = "Robot.findByUsersId", query = "SELECT r FROM Robot r WHERE r.user.id = :usersId"),
    @NamedQuery(name = "Robot.findByProgramAndUser", query = "SELECT r FROM Robot r WHERE r.programSourceId = :programSourceId AND r.user.id = :usersId")})
public class Robot implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * The robot id, primary key value.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    /**
     * The user owning the robot.
     */
    @ManyToOne
    @NotNull
    @JoinColumn(name = "usersId")
    private Users user;

    /**
     * The name of the robot.
     */
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "robotName")
    private String robotName;

    /**
     * The source code of the program currently active on the robot.
     */
    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 65535)
    @Column(name = "sourceCode")
    private String sourceCode;

    /**
     * The reference to the source program currently linked to the robot.
     * The linked source code will be copied to the active source code when
     * the robot changes are applied, but only when the linked source code
     * is valid and the robot is inactive.
     */
    @Column(name = "programSourceId")
    private Integer programSourceId;

    /**
     * The ore container robot part active on this robot.
     */
    @ManyToOne
    @NotNull
    @JoinColumn(name = "oreContainerId")
    private RobotPart oreContainer;

    /**
     * The mining unit robot part active on this robot.
     */
    @ManyToOne
    @NotNull
    @JoinColumn(name = "miningUnitId")
    private RobotPart miningUnit;

    /**
     * The battery unit robot part active on this robot.
     */
    @ManyToOne
    @NotNull
    @JoinColumn(name = "batteryId")
    private RobotPart battery;

    /**
     * The memory module unit robot part active on this robot.
     */
    @ManyToOne
    @NotNull
    @JoinColumn(name = "memoryModuleId")
    private RobotPart memoryModule;

    /**
     * The cpu unit robot part active on this robot.
     */
    @ManyToOne
    @NotNull
    @JoinColumn(name = "cpuId")
    private RobotPart cpu;

    /**
     * The engine unit robot part active on this robot.
     */
    @ManyToOne
    @NotNull
    @JoinColumn(name = "engineId")
    private RobotPart engine;

    /**
     * The recharge time for the robot, in seconds.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "rechargeTime")
    private int rechargeTime;

    /**
     * The ore capacity.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "maxOre")
    private int maxOre;

    /**
     * The maximum amount of ore the robot is able to mine each cycle. Please
     * note that the amount of ore mined in one cycle also cannot exceed
     * halve the ore available on a square.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "miningSpeed")
    private int miningSpeed;

    /**
     * The maximum number of turns the robot can operate before the battery
     * is depleted.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "maxTurns")
    private int maxTurns;

    /**
     * The maximum size of a program that can be applied to this robot.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "memorySize")
    private int memorySize;

    /**
     * The maximum number of program instructions the robot can process
     * each cycle. When the program doesn't activate a robot action like
     * move or mine before that, the robot will sit idle for that cycle and
     * the program processing will continue next cycle.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "cpuSpeed")
    private int cpuSpeed;

    /**
     * The maximum distance the robot can move forward each cycle.
     * When a move() instruction with a larger number is executed, the robot
     * moves this distance forward in one cycle and the rest of the
     * distance in the next cycle(s).
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "forwardSpeed")
    private double forwardSpeed;

    /**
     * The maximum distance the robot can move backward each cycle.
     * The same mechanism applies as for forward movement.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "backwardSpeed")
    private double backwardSpeed;

    /**
     * The maximum rotation a robot can execute each cycle. When a rotate()
     * with a larger angle is executed, the robot is rotated this angle in
     * one cycle and the rest of the requested angle in the next cycle(s).
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "rotateSpeed")
    private int rotateSpeed;

    /**
     * The size of the robot.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "robotSize")
    private int robotSize;

    /**
     * When in the future, the robot is currently recharging till this time
     * is passed.
     */
    @Column(name = "rechargeEndTime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date rechargeEndTime;

    /**
     * When in the future, the robot is currently mining till this time is
     * passed.
     */
    @Column(name = "miningEndTime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date miningEndTime;

    /**
     * The total number of mining runs this robot executed so far.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "totalMiningRuns")
    private int totalMiningRuns;

    /**
     * The total amounts of ore this robot mined so far.
     */
    @OneToMany
    @JoinColumn(name = "RobotLifetimeResult.robotId")
    private List<RobotLifetimeResult> robotLifetimeResultList;

    /**
     * Default constructor.
     */
    public Robot() {
    }

    /**
     * Retrieve the primary key value of the robot.
     * 
     * @return The id value of the robot.
     */
    public Integer getId() {
        return id;
    }

    /**
     * Retrieve the owner of the robot.
     * 
     * @return The owner of the robot.
     */
    public Users getUser() {
        return user;
    }

    /**
     * Change the owner of the robot.
     * 
     * @param user The new owner of the robot.
     */
    public void setUser(Users user) {
        this.user = user;
    }

    /**
     * Retrieve the name of the robot.
     * 
     * @return The name of the robot.
     */
    public String getRobotName() {
        return robotName;
    }

    /**
     * Change the name of the robot.
     *
     * @param robotName The new name of the robot.
     */
    public void setRobotName(String robotName) {
        this.robotName = robotName;
    }

    /**
     * Update the currently active source code for this robot. This program
     * source should always be valid.
     *
     * @param sourceCode The new program source.
     */
    public void setSourceCode(String sourceCode) {
        this.sourceCode = sourceCode;
    }

    /**
     * Retrieve the program source id this robot is linked to. Unlike the
     * sourceCode field, the linked code could currently be invalid or too
     * large to fit in the robot memory.
     *
     * @return The program source id this robot is linked to.
     */
    public Integer getProgramSourceId() {
        return programSourceId;
    }

    /**
     * Update the program source id this robot is linked to.
     * 
     * @param programSourceId The new program source id this robot is linked to.
     */
    public void setProgramSourceId(Integer programSourceId) {
        this.programSourceId = programSourceId;
    }

    /**
     * Retrieve the ore container robot part linked to this robot.
     *
     * @return The ore container robot part linked to this robot.
     */
    public RobotPart getOreContainer() {
        return oreContainer;
    }

    /**
     * Update the ore container robot part linked to this robot.
     *
     * @param oreContainer The ore container robot part linked to this robot.
     */
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

    public int getTotalMiningRuns() {
        return totalMiningRuns;
    }

    public void setTotalMiningRuns(int totalMiningRuns) {
        this.totalMiningRuns = totalMiningRuns;
    }

    public void increateTotalMiningRuns() {
        ++totalMiningRuns;
    }

    public List<RobotLifetimeResult> getRobotLifetimeResultList() {
        return robotLifetimeResultList;
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

        setTotalMiningRuns(0);

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

        setForwardSpeed(3 * forwardCapacity / weight);
        setBackwardSpeed(3 * backwardCapacity / weight);
        setRotateSpeed((int)(20 * rotateCapacity / weight));

        setRobotSize((int) Math.pow(volume, 0.33));
    }
}
