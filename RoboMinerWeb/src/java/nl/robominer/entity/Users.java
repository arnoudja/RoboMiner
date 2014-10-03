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

import bcrypt.BCrypt;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.MapKey;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Entity class for the user account information.
 *
 * @author Arnoud Jagerman
 */
@Entity
@Table(name = "Users")
@XmlRootElement
@NamedQueries(
{
    @NamedQuery(name = "Users.findAll", query = "SELECT u FROM Users u"),
    @NamedQuery(name = "Users.findById",
                query = "SELECT u FROM Users u WHERE u.id = :id"),
    @NamedQuery(name = "Users.findByUsername",
                query = "SELECT u FROM Users u WHERE u.username = :username"),
    @NamedQuery(name = "Users.findByEmail",
                query = "SELECT u FROM Users u WHERE u.email = :email"),
    @NamedQuery(name = "Users.findByUsernameOrEmail",
                query = "SELECT u FROM Users u WHERE u.username = :name OR u.email = :name")
})
public class Users implements Serializable
{
    private static final long serialVersionUID = 1L;

    /**
     * The regular expression for valid usernames.
     */
    private static final String USERNAME_REGEXP = "[A-Za-z0-9]{3,30}";

    /**
     * The regular expression for valid email addresses.
     */
    private static final String EMAIL_REGEXP = ".+@.+";

    /**
     * The minimum password length.
     */
    private static final int MIN_PASSWORD_LENGTH = 8;

    /**
     * The primary key id value of the user.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    /**
     * The username of the user.
     */
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "username")
    private String username;

    /**
     * The email address of the user.
     */
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "email")
    private String email;

    /**
     * The hashed password.
     */
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "password")
    private String password;

    /**
     * The number of achievement points earned.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "achievementPoints")
    private int achievementPoints;

    /**
     * The maximum mining queue size.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "miningQueueSize")
    private int miningQueueSize;

    /**
     * The list of mining areas the user is allowed to mine in.
     */
    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(
            name = "UserMiningArea",
            joinColumns = @JoinColumn(name = "usersId"),
            inverseJoinColumns = @JoinColumn(name = "miningAreaId")
    )
    private List<MiningArea> miningAreaList;

    /**
     * A map of the user ore asset values.
     */
    @OneToMany
    @JoinColumn(name = "UserOreAsset.usersId")
    @MapKey(name = "oreId")
    private Map<Integer, UserOreAsset> userOreAssets;

    /**
     * The list of robots owned by the user.
     */
    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "Robot.usersId")
    private List<Robot> robotList;

    /**
     * The list of robot program sources owned by the user.
     */
    @OneToMany
    @JoinColumn(name = "ProgramSource.usersId")
    private List<ProgramSource> programSourceList;

    /**
     * The list of robot parts owned by the user.
     */
    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "UserRobotPartAsset.usersId")
    private List<UserRobotPartAsset> userRobotPartAssetList;

    /**
     * Default constructor.
     */
    public Users()
    {
    }

    /**
     * Retrieve the primary key id value of the user.
     *
     * @return The primary key id value.
     */
    public Integer getId()
    {
        return id;
    }

    /**
     * Retrieve the username.
     *
     * @return The username.
     */
    public String getUsername()
    {
        return username;
    }

    /**
     * Set the new username, if valid.
     *
     * @param username The new username.
     *
     * @return true if the username was changed successful, false if the new
     *         username is invalid.
     */
    public boolean setUsername(String username)
    {
        boolean result = false;

        if (username != null && username.matches(USERNAME_REGEXP))
        {
            this.username = username;
            result = true;
        }

        return result;
    }

    /**
     * Retrieve the e-mail address of the user.
     *
     * @return The e-mail address of the user.
     */
    public String getEmail()
    {
        return email;
    }

    /**
     * Set the new e-mail address, if valid.
     *
     * @param email The new e-mail address.
     *
     * @return true if the e-mail address was changed successful, false if the
     *         new e-mail address is invalid.
     */
    public boolean setEmail(String email)
    {
        boolean result = false;

        if (email != null && email.matches(EMAIL_REGEXP))
        {

            this.email = email;
            result = true;
        }

        return result;
    }

    /**
     * Verify the supplied password.
     *
     * @param password The password to check.
     *
     * @return true if the supplied password matches the user password, false if
     *         not.
     */
    public boolean verifyPassword(String password)
    {
        return (password != null && BCrypt.checkpw(password, this.password));
    }

    /**
     * Set the new password, if valid.
     *
     * @param password The new password to set.
     *
     * @return true if the password is set successful, false if the new password
     *         doesn't meet the requirements.
     */
    public boolean setPassword(String password)
    {
        boolean result = false;

        if (password != null && password.length() >= MIN_PASSWORD_LENGTH)
        {
            this.password = BCrypt.hashpw(password, BCrypt.gensalt());
            result = true;
        }

        return result;
    }

    /**
     * Retrieve the number of achievement points of the user.
     *
     * @return The number of achievement points.
     */
    public int getAchievementPoints()
    {
        return achievementPoints;
    }

    /**
     * Increase the number of achievement points of the user.
     *
     * @param achievementPoints The achievement points increment value.
     */
    public void increaseAchievementPoints(int achievementPoints)
    {
        this.achievementPoints += achievementPoints;
    }

    /**
     * Retrieve the maximum mining queue size.
     *
     * @return The maximum mining queue size.
     */
    public int getMiningQueueSize()
    {
        return miningQueueSize;
    }

    /**
     * Set the maximum mining queue size.
     *
     * @param miningQueueSize The maximum mining queue size.
     */
    public void setMiningQueueSize(int miningQueueSize)
    {
        this.miningQueueSize = miningQueueSize;
    }

    /**
     * Increase the maximum mining queue size.
     *
     * @param miningQueueIncrement The maximum mining queue size increment.
     */
    public void increaseMiningQueueSize(int miningQueueIncrement)
    {
        this.miningQueueSize += miningQueueIncrement;
    }

    /**
     * Retrieve the list of mining areas the user is allowed to mine in.
     *
     * @return The list of mining areas.
     */
    public List<MiningArea> getMiningAreaList()
    {
        return miningAreaList;
    }

    /**
     * Return the mining area for the specified mining area id if the user has
     * access to that mining area, or null otherwise.
     *
     * @param miningAreaId The requested mining area id.
     *
     * @return The mining area instance, or null if the user doesn't have
     *         access.
     */
    public MiningArea getMiningArea(int miningAreaId)
    {
        for (MiningArea miningArea : miningAreaList)
        {
            if (miningArea.getId() == miningAreaId)
            {
                return miningArea;
            }
        }

        return null;
    }

    /**
     * Add a mining area to the list of mining areas the user is allowed to mine
     * in.
     *
     * @param miningArea The mining area to add.
     */
    public void addMiningArea(MiningArea miningArea)
    {
        boolean found = false;

        for (MiningArea existingArea : miningAreaList)
        {
            if (Objects.equals(existingArea.getId(), miningArea.getId()))
            {
                found = true;
            }
        }

        if (!found)
        {
            miningAreaList.add(miningArea);
        }
    }

    /**
     * Retrieve a map of the ore-ids to the ore asset values for the user.
     *
     * @return The ore-id to ore asset values mapping.
     */
    public Map<Integer, UserOreAsset> getUserOreAssets()
    {
        return userOreAssets;
    }

    /**
     * Retrieve the amount of ore owned by the user for a specific ore type.
     *
     * @param oreId The ore type id to retrieve the amount owned for.
     *
     * @return The amount of ore owned.
     */
    public int getUserOreAmount(int oreId)
    {
        UserOreAsset asset = userOreAssets.get(oreId);
        return asset == null ? 0 : asset.getAmount();
    }

    /**
     * Retrieve the user robot part asset for the specified robot part id.
     *
     * @param robotPartId The id of the robot part to return the asset for.
     *
     * @return The robot part asset.
     */
    public UserRobotPartAsset getUserRobotPartAsset(int robotPartId)
    {
        for (UserRobotPartAsset userRobotPartAsset : userRobotPartAssetList)
        {
            if (userRobotPartAsset.getRobotPartId() == robotPartId)
            {
                return userRobotPartAsset;
            }
        }

        return null;
    }

    /**
     * Retrieve the total amount of the specified robot part the user owns.
     *
     * @param robotPartId The id of the robot part to retrieve the amount for.
     *
     * @return The total amount of the specified robot part the user owns.
     */
    public int getTotalRobotPartAmount(int robotPartId)
    {
        UserRobotPartAsset asset = getUserRobotPartAsset(robotPartId);
        return asset == null ? 0 : asset.getTotalOwned();
    }

    /**
     * Retrieve the unassigned amount of the specified robot part the user owns.
     *
     * @param robotPartId The id of the robot part to retrieve the amount for.
     *
     * @return The unassigned amount of the specified robot part the user owns.
     */
    public int getUnassignedRobotPartAmount(int robotPartId)
    {
        UserRobotPartAsset asset = getUserRobotPartAsset(robotPartId);
        return asset == null ? 0 : asset.getUnassigned();
    }

    /**
     * Retrieve the list of robots the user owns.
     *
     * @return The list of robots.
     */
    public List<Robot> getRobotList()
    {
        return robotList;
    }

    /**
     * Retrieve the specified user robot.
     *
     * @param robotId The id of the robot to retrieve.
     *
     * @return The robot instance, or null if not found.
     */
    public Robot getRobot(int robotId)
    {
        for (Robot robot : robotList)
        {
            if (robot.getId() == robotId)
            {
                return robot;
            }
        }

        return null;
    }

    /**
     * Retrieve the list of robot program sources the user owns.
     *
     * @return The list of robot program sources.
     */
    public List<ProgramSource> getProgramSourceList()
    {
        return programSourceList;
    }

    /**
     * Retrieve the specified user program source.
     *
     * @param programSourceId The id of the user program source to retrieve.
     *
     * @return The program source instance, or null if not found.
     */
    public ProgramSource getProgramSource(int programSourceId)
    {
        for (ProgramSource programSource : programSourceList)
        {
            if (programSource.getId() == programSourceId)
            {
                return programSource;
            }
        }

        return null;
    }

    /**
     * Retrieve the list of user robot part assets.
     *
     * @return The list of user robot part assets.
     */
    public List<UserRobotPartAsset> getUserRobotPartAssetList()
    {
        return userRobotPartAssetList;
    }

    /**
     * Retrieve the list of user robot part assets of the specified type.
     *
     * @param robotPartTypeId The robot part type id to filter on.
     *
     * @return The list of user robot part assets of the specified type.
     */
    public List<UserRobotPartAsset> getUserRobotPartAssetListOfType(
            int robotPartTypeId)
    {
        List<UserRobotPartAsset> result = new ArrayList<>();

        for (UserRobotPartAsset userRobotPartAsset : userRobotPartAssetList)
        {
            if (userRobotPartAsset.getRobotPart().getRobotPartType().getId() ==
                    robotPartTypeId)
            {
                result.add(userRobotPartAsset);
            }
        }

        return result;
    }

    /**
     * Retrieve the mining score of the best robot for the specified mining
     * area.
     *
     * @param miningAreaId The mining area to retrieve the score for.
     *
     * @return The score of the best robot for the specified mining area.
     */
    public double getMiningAreaScore(int miningAreaId)
    {
        double score = .0;

        for (Robot robot : robotList)
        {
            score = Math.max(score, robot.getMiningAreaScore(miningAreaId));
        }

        return score;
    }

    /**
     * Checks whether the user has enough resources to pay an ore price.
     *
     * @param orePrice The price to check for.
     *
     * @return true if the user has enough resources, false if not.
     */
    public boolean canAffort(OrePrice orePrice)
    {
        boolean result = true;

        List<OrePriceAmount> orePriceAmountList = orePrice.getOrePriceAmountList();
        for (OrePriceAmount orePriceAmount : orePriceAmountList)
        {
            if (orePriceAmount.getAmount() > getUserOreAmount(orePriceAmount
                    .getOre().getId()))
            {
                result = false;
            }
        }

        return result;
    }

    /**
     * Fill the default values for a new user.
     */
    public void fillDefaults()
    {
        achievementPoints = 0;
        miningQueueSize = 0;
    }

    /**
     * Retrieve the hash value of the primary key.
     *
     * @return
     */
    @Override
    public int hashCode()
    {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    /**
     * Checks whether the specified object represents the same user as this
     * instance.
     *
     * @param object The object to check against.
     *
     * @return true if both objects represent the same user.
     */
    @Override
    public boolean equals(Object object)
    {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Users))
        {
            return false;
        }
        Users other = (Users)object;
        return (this.id != null || other.id == null) &&
                (this.id == null || this.id.equals(other.id));
    }

    /**
     * Retrieve a string representation of the primary key value.
     *
     * @return A string representation of the primary key value.
     */
    @Override
    public String toString()
    {
        return "nl.robominer.entity.Users[ id=" + id + " ]";
    }
}
