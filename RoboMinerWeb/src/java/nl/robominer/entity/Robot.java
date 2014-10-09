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
import javax.persistence.CascadeType;
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
@NamedQueries(
{
    @NamedQuery(name = "Robot.findAll", query = "SELECT r FROM Robot r"),
    @NamedQuery(name = "Robot.findById",
                query = "SELECT r FROM Robot r WHERE r.id = :id"),
    @NamedQuery(name = "Robot.findByIdAndUser",
                query = "SELECT r FROM Robot r WHERE r.id = :id AND r.user.id = :usersId"),
    @NamedQuery(name = "Robot.findByUsersId",
                query = "SELECT r FROM Robot r WHERE r.user.id = :usersId"),
    @NamedQuery(name = "Robot.findByProgramAndUser",
                query = "SELECT r FROM Robot r WHERE r.programSourceId = :programSourceId AND r.user.id = :usersId")
})
public class Robot implements Serializable
{
    private static final long serialVersionUID = 1L;

    /**
     * The regular expression specifying valid robot names.
     */
    private static final String ROBOT_NAME_REGEXP = "[A-Za-z0-9_]{1,15}";

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
     * The reference to the source program currently linked to the robot. The
     * linked source code will be copied to the active source code when the
     * robot changes are applied, but only when the linked source code is valid
     * and the robot is inactive.
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
     * note that the amount of ore mined in one cycle also cannot exceed halve
     * the ore available on a square.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "miningSpeed")
    private int miningSpeed;

    /**
     * The maximum number of turns the robot can operate before the battery is
     * depleted.
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
     * The maximum number of program instructions the robot can process each
     * cycle. When the program doesn't activate a robot action like move or mine
     * before that, the robot will sit idle for that cycle and the program
     * processing will continue next cycle.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "cpuSpeed")
    private int cpuSpeed;

    /**
     * The maximum distance the robot can move forward each cycle. When a move()
     * instruction with a larger number is executed, the robot moves this
     * distance forward in one cycle and the rest of the distance in the next
     * cycle(s).
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "forwardSpeed")
    private double forwardSpeed;

    /**
     * The maximum distance the robot can move backward each cycle. The same
     * mechanism applies as for forward movement.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "backwardSpeed")
    private double backwardSpeed;

    /**
     * The maximum rotation a robot can execute each cycle. When a rotate() with
     * a larger angle is executed, the robot is rotated this angle in one cycle
     * and the rest of the requested angle in the next cycle(s).
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
    private double robotSize;

    /**
     * When in the future, the robot is currently recharging till this time is
     * passed.
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
     * The mining score per mining area.
     */
    @OneToMany
    @JoinColumn(name = "RobotMiningAreaScore.robotId")
    private List<RobotMiningAreaScore> robotMiningAreaScoreList;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "PendingRobotChanges.robotId")
    private List<PendingRobotChanges> pendingRobotChangesList;

    /**
     * Default constructor.
     */
    public Robot()
    {
    }

    /**
     * Construct a new robot for the specified user.
     *
     * @param user The user to construct the robot for.
     */
    public Robot(Users user)
    {
        this.user = user;
        
        generateRobotName(user.getUsername(), user.getRobotList().size() + 1);
    }

    /**
     * Retrieve the primary key value of the robot.
     *
     * @return The id value of the robot.
     */
    public Integer getId()
    {
        return id;
    }

    /**
     * Retrieve the owner of the robot.
     *
     * @return The owner of the robot.
     */
    public Users getUser()
    {
        return user;
    }

    /**
     * Change the owner of the robot.
     *
     * @param user The new owner of the robot.
     */
    public void setUser(Users user)
    {
        this.user = user;
    }

    /**
     * Retrieve the name of the robot.
     *
     * @return The name of the robot.
     */
    public String getRobotName()
    {
        return robotName;
    }

    /**
     * Change the name of the robot.
     *
     * @param robotName The new name of the robot.
     *
     * @throws IllegalArgumentException if the specified name is not allowed.
     */
    public void setRobotName(String robotName) throws IllegalArgumentException
    {
        if (!robotName.matches(ROBOT_NAME_REGEXP))
        {
            throw new IllegalArgumentException();
        }

        this.robotName = robotName;
    }

    /**
     * Generate the name for a new robot.
     *
     * @param username The username of the new owner of the robot.
     * @param robotNumber The robot-number for the user.
     */
    private void generateRobotName(String username, int robotNumber)
    {
        if (username.length() > 10)
        {
            robotName = username.substring(0, 10);
        }
        else
        {
            robotName = username;
        }
        
        robotName = robotName + "_" + robotNumber;
    }

    /**
     * Retrieve the currently active source code for this robot.
     *
     * @return The currently active source code for this robot.
     */
    public String getSourceCode()
    {
        if (!getChangePending())
        {
            return this.sourceCode;
        }
        else
        {
            return pendingRobotChangesList.get(0).getSourceCode();
        }
    }

    /**
     * Update the currently active source code for this robot. This program
     * source should always be valid.
     *
     * @param sourceCode The new program source.
     */
    public void setSourceCode(String sourceCode)
    {
        if (!getChangePending())
        {
            this.sourceCode = sourceCode;
        }
        else
        {
            pendingRobotChangesList.get(0).setSourceCode(sourceCode);
        }
    }

    /**
     * Retrieve the program source id this robot is linked to. Unlike the
     * sourceCode field, the linked code could currently be invalid or too large
     * to fit in the robot memory.
     *
     * @return The program source id this robot is linked to.
     */
    public Integer getProgramSourceId()
    {
        return programSourceId;
    }

    /**
     * Update the program source id this robot is linked to.
     *
     * @param programSourceId The new program source id this robot is linked to.
     */
    public void setProgramSourceId(Integer programSourceId)
    {
        this.programSourceId = programSourceId;
    }

    /**
     * Retrieve the ore container robot part linked to this robot.
     *
     * @return The ore container robot part linked to this robot.
     */
    public RobotPart getOreContainer()
    {
        if (!getChangePending())
        {
            return oreContainer;
        }
        else
        {
            return pendingRobotChangesList.get(0).getOreContainer();
        }
    }

    /**
     * Update the ore container robot part linked to this robot.
     *
     * @param oreContainer The ore container robot part linked to this robot.
     */
    public void setOreContainer(RobotPart oreContainer)
    {
        if (!getChangePending())
        {
            this.oreContainer = oreContainer;
        }
        else
        {
            pendingRobotChangesList.get(0).setOreContainer(oreContainer);
        }
    }

    public RobotPart getMiningUnit()
    {
        if (!getChangePending())
        {
            return miningUnit;
        }
        else
        {
            return pendingRobotChangesList.get(0).getMiningUnit();
        }
    }

    public void setMiningUnit(RobotPart miningUnit)
    {
        if (!getChangePending())
        {
            this.miningUnit = miningUnit;
        }
        else
        {
            pendingRobotChangesList.get(0).setMiningUnit(miningUnit);
        }
    }

    public RobotPart getBattery()
    {
        if (!getChangePending())
        {
            return battery;
        }
        else
        {
            return pendingRobotChangesList.get(0).getBattery();
        }
    }

    public void setBattery(RobotPart battery)
    {
        if (!getChangePending())
        {
            this.battery = battery;
        }
        else
        {
            pendingRobotChangesList.get(0).setBattery(battery);
        }
    }

    public RobotPart getMemoryModule()
    {
        if (!getChangePending())
        {
            return memoryModule;
        }
        else
        {
            return pendingRobotChangesList.get(0).getMemoryModule();
        }
    }

    public void setMemoryModule(RobotPart memoryModule)
    {
        if (!getChangePending())
        {
            this.memoryModule = memoryModule;
        }
        else
        {
            pendingRobotChangesList.get(0).setMemoryModule(memoryModule);
        }
    }

    public RobotPart getCpu()
    {
        if (!getChangePending())
        {
            return cpu;
        }
        else
        {
            return pendingRobotChangesList.get(0).getCpu();
        }
    }

    public void setCpu(RobotPart cpu)
    {
        if (!getChangePending())
        {
            this.cpu = cpu;
        }
        else
        {
            pendingRobotChangesList.get(0).setCpu(cpu);
        }
    }

    public RobotPart getEngine()
    {
        if (!getChangePending())
        {
            return engine;
        }
        else
        {
            return pendingRobotChangesList.get(0).getEngine();
        }
    }

    public void setEngine(RobotPart engine)
    {
        if (!getChangePending())
        {
            this.engine = engine;
        }
        else
        {
            pendingRobotChangesList.get(0).setEngine(engine);
        }
    }

    public int getRechargeTime()
    {
        if (!getChangePending())
        {
            return rechargeTime;
        }
        else
        {
            return pendingRobotChangesList.get(0).getRechargeTime();
        }
    }

    public void setRechargeTime(int rechargeTime)
    {
        if (!getChangePending())
        {
            this.rechargeTime = rechargeTime;
        }
        else
        {
            pendingRobotChangesList.get(0).setRechargeTime(rechargeTime);
        }
    }

    public int getMaxOre()
    {
        if (!getChangePending())
        {
            return maxOre;
        }
        else
        {
            return pendingRobotChangesList.get(0).getMaxOre();
        }
    }

    public void setMaxOre(int maxOre)
    {
        if (!getChangePending())
        {
            this.maxOre = maxOre;
        }
        else
        {
            pendingRobotChangesList.get(0).setMaxOre(maxOre);
        }
    }

    public int getMiningSpeed()
    {
        if (!getChangePending())
        {
            return miningSpeed;
        }
        else
        {
            return pendingRobotChangesList.get(0).getMiningSpeed();
        }
    }

    public void setMiningSpeed(int miningSpeed)
    {
        if (!getChangePending())
        {
            this.miningSpeed = miningSpeed;
        }
        else
        {
            pendingRobotChangesList.get(0).setMiningSpeed(miningSpeed);
        }
    }

    public int getMaxTurns()
    {
        if (!getChangePending())
        {
            return maxTurns;
        }
        else
        {
            return pendingRobotChangesList.get(0).getMaxTurns();
        }
    }

    public void setMaxTurns(int maxTurns)
    {
        if (!getChangePending())
        {
            this.maxTurns = maxTurns;
        }
        else
        {
            pendingRobotChangesList.get(0).setMaxTurns(maxTurns);
        }
    }

    public int getMemorySize()
    {
        if (!getChangePending())
        {
            return memorySize;
        }
        else
        {
            return pendingRobotChangesList.get(0).getMemorySize();
        }
    }

    public void setMemorySize(int memorySize)
    {
        if (!getChangePending())
        {
            this.memorySize = memorySize;
        }
        else
        {
            pendingRobotChangesList.get(0).setMemorySize(memorySize);
        }
    }

    public int getCpuSpeed()
    {
        if (!getChangePending())
        {
            return cpuSpeed;
        }
        else
        {
            return pendingRobotChangesList.get(0).getCpuSpeed();
        }
    }

    public void setCpuSpeed(int cpuSpeed)
    {
        if (!getChangePending())
        {
            this.cpuSpeed = cpuSpeed;
        }
        else
        {
            pendingRobotChangesList.get(0).setCpuSpeed(cpuSpeed);
        }
    }

    public double getForwardSpeed()
    {
        if (!getChangePending())
        {
            return forwardSpeed;
        }
        else
        {
            return pendingRobotChangesList.get(0).getForwardSpeed();
        }
    }

    public void setForwardSpeed(double forwardSpeed)
    {
        if (!getChangePending())
        {
            this.forwardSpeed = forwardSpeed;
        }
        else
        {
            pendingRobotChangesList.get(0).setForwardSpeed(forwardSpeed);
        }
    }

    public double getBackwardSpeed()
    {
        if (!getChangePending())
        {
            return backwardSpeed;
        }
        else
        {
            return pendingRobotChangesList.get(0).getBackwardSpeed();
        }
    }

    public void setBackwardSpeed(double backwardSpeed)
    {
        if (!getChangePending())
        {
            this.backwardSpeed = backwardSpeed;
        }
        else
        {
            pendingRobotChangesList.get(0).setBackwardSpeed(backwardSpeed);
        }
    }

    public int getRotateSpeed()
    {
        if (!getChangePending())
        {
            return rotateSpeed;
        }
        else
        {
            return pendingRobotChangesList.get(0).getRotateSpeed();
        }
    }

    public void setRotateSpeed(int rotateSpeed)
    {
        if (!getChangePending())
        {
            this.rotateSpeed = rotateSpeed;
        }
        else
        {
            pendingRobotChangesList.get(0).setRotateSpeed(rotateSpeed);
        }
    }

    public double getRobotSize()
    {
        if (!getChangePending())
        {
            return robotSize;
        }
        else
        {
            return pendingRobotChangesList.get(0).getRobotSize();
        }
    }

    public void setRobotSize(double robotSize)
    {
        if (!getChangePending())
        {
            this.robotSize = robotSize;
        }
        else
        {
            pendingRobotChangesList.get(0).setRobotSize(robotSize);
        }
    }

    public Date getRechargeEndTime()
    {
        return rechargeEndTime;
    }

    public void setRechargeEndTime(Date rechargeEndTime)
    {
        this.rechargeEndTime = rechargeEndTime;
    }

    public Date getMiningEndTime()
    {
        return miningEndTime;
    }

    public void setMiningEndTime(Date miningEndTime)
    {
        this.miningEndTime = miningEndTime;
    }

    public int getTotalMiningRuns()
    {
        return totalMiningRuns;
    }

    public void setTotalMiningRuns(int totalMiningRuns)
    {
        this.totalMiningRuns = totalMiningRuns;
    }

    public void increateTotalMiningRuns()
    {
        ++totalMiningRuns;
    }

    public List<RobotLifetimeResult> getRobotLifetimeResultList()
    {
        return robotLifetimeResultList;
    }

    public double getMiningAreaScore(int miningAreaId)
    {
        for (RobotMiningAreaScore robotMiningAreaScore
             : robotMiningAreaScoreList)
        {
            if (robotMiningAreaScore.getMiningAreaId() == miningAreaId)
            {
                return robotMiningAreaScore.getScore();
            }
        }

        return .0;
    }

    public PendingRobotChanges getPendingRobotChanges()
    {
        return (pendingRobotChangesList == null ||
                pendingRobotChangesList.isEmpty()) ? null : pendingRobotChangesList.get(0);
    }

    public boolean getChangePending()
    {
        return !(pendingRobotChangesList == null || pendingRobotChangesList.isEmpty());
    }

    public void makeChangesPending()
    {
        pendingRobotChangesList.add(new PendingRobotChanges(this));
    }

    public boolean isRecharging()
    {
        Date now = new Date();

        return ( getRechargeEndTime().after(now) &&
                 ( getMiningEndTime() == null ||
                   getMiningEndTime().before(now) ||
                   getMiningEndTime().after(getRechargeEndTime()) ) );
    }

    public void fillDefaults(RobotPart oreContainer, RobotPart miningUnit,
                             RobotPart battery,
                             RobotPart memoryModule, RobotPart cpu,
                             RobotPart engine)
    {
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

    public void updateParameters()
    {
        PendingRobotChanges pendingRobotChanges = getPendingRobotChanges();

        RobotPart calculateOreContainer = (pendingRobotChanges == null) ?
                   this.oreContainer : pendingRobotChanges.getOreContainer();
        RobotPart calculateMiningUnit = (pendingRobotChanges == null) ?
                   this.miningUnit : pendingRobotChanges.getMiningUnit();
        RobotPart calculateBattery = (pendingRobotChanges == null) ?
                   this.battery : pendingRobotChanges.getBattery();
        RobotPart calculateMemoryModule = (pendingRobotChanges == null) ?
                   this.memoryModule : pendingRobotChanges.getMemoryModule();
        RobotPart calculateCpu = (pendingRobotChanges == null) ?
                   this.cpu : pendingRobotChanges.getCpu();
        RobotPart calculateEngine = (pendingRobotChanges == null) ?
                   this.engine : pendingRobotChanges.getEngine();

        int batteryCapacity = calculateOreContainer.getBatteryCapacity() +
                calculateMiningUnit.getBatteryCapacity() +
                calculateBattery.getBatteryCapacity() +
                calculateMemoryModule.getBatteryCapacity() +
                calculateCpu.getBatteryCapacity() +
                calculateEngine.getBatteryCapacity();

        int powerUsage = calculateOreContainer.getPowerUsage() +
                calculateMiningUnit.getPowerUsage() +
                calculateBattery.getPowerUsage() +
                calculateMemoryModule.getPowerUsage() +
                calculateCpu.getPowerUsage() + calculateEngine.getPowerUsage();

        double weight = calculateOreContainer.getWeight() +
                calculateMiningUnit.getWeight() +
                calculateBattery.getWeight() +
                calculateMemoryModule.getWeight() +
                calculateCpu.getWeight() + calculateEngine.getWeight();

        int volume = calculateOreContainer.getVolume() +
                calculateMiningUnit.getVolume() +
                calculateBattery.getVolume() +
                calculateMemoryModule.getVolume() +
                calculateCpu.getVolume() + calculateEngine.getVolume();

        double forwardCapacity = calculateOreContainer.getForwardCapacity() +
                calculateMiningUnit.getForwardCapacity() +
                calculateBattery.getForwardCapacity() +
                calculateMemoryModule.getForwardCapacity() +
                calculateCpu.getForwardCapacity() +
                calculateEngine.getForwardCapacity();

        double backwardCapacity = calculateOreContainer.getBackwardCapacity() +
                calculateMiningUnit.getBackwardCapacity() +
                calculateBattery.getBackwardCapacity() +
                calculateMemoryModule.getBackwardCapacity() +
                calculateCpu.getBackwardCapacity() +
                calculateEngine.getBackwardCapacity();

        int rotateCapacity = calculateOreContainer.getRotateCapacity() +
                calculateMiningUnit.getRotateCapacity() +
                calculateBattery.getRotateCapacity() +
                calculateMemoryModule.getRotateCapacity() +
                calculateCpu.getRotateCapacity() +
                calculateEngine.getRotateCapacity();

        setRechargeTime(calculateOreContainer.getRechargeTime() +
                calculateMiningUnit.getRechargeTime() +
                calculateBattery.getRechargeTime() +
                calculateMemoryModule.getRechargeTime() +
                calculateCpu.getRechargeTime() +
                calculateEngine.getRechargeTime());

        setMaxOre(calculateOreContainer.getOreCapacity() +
                calculateMiningUnit.getOreCapacity() +
                calculateBattery.getOreCapacity() +
                calculateMemoryModule.getOreCapacity() +
                calculateCpu.getOreCapacity() +
                calculateEngine.getOreCapacity());

        setMiningSpeed(calculateOreContainer.getMiningCapacity() +
                calculateMiningUnit.getMiningCapacity() +
                calculateBattery.getMiningCapacity() +
                calculateMemoryModule.getMiningCapacity() +
                calculateCpu.getMiningCapacity() +
                calculateEngine.getMiningCapacity());

        setMemorySize(calculateOreContainer.getMemoryCapacity() +
                calculateMiningUnit.getMemoryCapacity() +
                calculateBattery.getMemoryCapacity() +
                calculateMemoryModule.getMemoryCapacity() +
                calculateCpu.getMemoryCapacity() +
                calculateEngine.getMemoryCapacity());

        setCpuSpeed(
                calculateOreContainer.getCpuCapacity() +
                calculateMiningUnit.getCpuCapacity() +
                calculateBattery.getCpuCapacity() +
                calculateMemoryModule.getCpuCapacity() +
                calculateCpu.getCpuCapacity() +
                calculateEngine.getCpuCapacity());

        setMaxTurns(batteryCapacity / powerUsage);

        setForwardSpeed(3 * forwardCapacity / weight);
        setBackwardSpeed(3 * backwardCapacity / weight);
        setRotateSpeed((int)(20 * rotateCapacity / weight));

        setRobotSize(Math.pow(volume, 0.33) / 2.);
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
        if (!(object instanceof Robot))
        {
            return false;
        }

        Robot other = (Robot)object;
        return Objects.equals(this.id, other.getId());
    }

    @Override
    public String toString()
    {
        return "nl.robominer.entity.Robot[ id=" + id + " ]";
    }
}
