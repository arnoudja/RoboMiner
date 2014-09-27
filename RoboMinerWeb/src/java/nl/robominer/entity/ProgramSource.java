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
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Entity class for the Robot Program data.
 *
 * @author Arnoud Jagerman
 */
@Entity
@Table(name = "ProgramSource")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ProgramSource.findAll", query = "SELECT p FROM ProgramSource p"),
    @NamedQuery(name = "ProgramSource.findById", query = "SELECT p FROM ProgramSource p WHERE p.id = :id"),
    @NamedQuery(name = "ProgramSource.findSuiteableByUsersId", query = "SELECT p FROM ProgramSource p WHERE p.usersId = :usersId AND p.compiledSize <= :maxSize AND p.verified = TRUE ORDER BY p.id")})
public class ProgramSource implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * The primary key id value of the program source data.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    /**
     * The user owning the program source.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "usersId")
    private int usersId;

    /**
     * The name of the program source.
     */
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "sourceName")
    private String sourceName;

    /**
     * Flag indicating whether the source code is syntactically correct.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "verified")
    private boolean verified;

    /**
     * The compiled size of the source code.
     */
    @Basic(optional = false)
    @NotNull
    @Column(name = "compiledSize")
    private int compiledSize;

    /**
     * The error message when the source code is not syntactically correct,
     * or empty otherwise.
     */
    @Size(max = 255)
    @Column(name = "errorDescription")
    private String errorDescription;

    /**
     * The program source code itself.
     */
    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 65535)
    @Column(name = "sourceCode")
    private String sourceCode;

    /**
     * The list of robots using this program.
     */
    @OneToMany
    @JoinColumn(name = "Robot.programSourceId")
    private List<Robot> robotList;

    /**
     * Default constructor.
     */
    public ProgramSource() {
    }

    /**
     * Constructor.
     *
     * @param usersId The id of the user owning this new program source.
     */
    public ProgramSource(int usersId) {

        this.usersId          = usersId;
        this.verified         = true;
        this.compiledSize     = 4;
        this.errorDescription = "";
        this.sourceCode       = "move(1);\nmine();";
    }

    /**
     * Retrieve the primary key id value of this instance.
     *
     * @return The primary key id value of this instance.
     */
    public Integer getId() {
        return id;
    }

    /**
     * Retrieve the primary key id value of the user owning this program source.
     *
     * @return The primary key id value of the user owning this program source.
     */
    public int getUsersId() {
        return usersId;
    }

    /**
     * Retrieve the name of the program source.
     *
     * @return The program source name.
     */
    public String getSourceName() {
        return sourceName;
    }

    /**
     * Change the name of the program source.
     *
     * @param sourceName The new program source name.
     */
    public void setSourceName(String sourceName) {
        this.sourceName = sourceName;
    }

    /**
     * Retrieve the verified-flag of the program source.
     *
     * @return true when the program is verified and syntactically correct,
     * false otherwise.
     */
    public boolean getVerified() {
        return verified;
    }

    /**
     * Change the verified-flag.
     *
     * @param verified The new value of the verified-flag.
     */
    public void setVerified(boolean verified) {
        this.verified = verified;
    }

    /**
     * Retrieve the size of the compiled program source.
     *
     * @return The size of the compiled program source.
     */
    public int getCompiledSize() {
        return compiledSize;
    }

    /**
     * Retrieve the error description of the last compilation attempt.
     *
     * @return The error description of the last compilation attempt, or
     * empty if none.
     */
    public String getErrorDescription() {
        return errorDescription;
    }

    /**
     * Retrieve the source code of the program.
     *
     * @return The source code.
     */
    public String getSourceCode() {
        return sourceCode;
    }

    /**
     * Change the source code of the program.
     *
     * @param sourceCode The new source code.
     */
    public void setSourceCode(String sourceCode) {
        this.sourceCode = sourceCode;
    }

    /**
     * Retrieve the list of robots using this program.
     *
     * @return The list of robots using this program.
     */
    public List<Robot> getRobotList() {
        return robotList;
    }

    /**
     * Retrieve the hash code for this instance.
     *
     * @return The hash code for this instance.
     */
    @Override
    public int hashCode() {
        return (id != null ? id.hashCode() : 0);
    }

    /**
     * Check whether this instance and the other instance represent the same
     * program source.
     *
     * @param object The instance to check with.
     *
     * @return true if both instances represent the same program source, else
     * false.
     */
    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProgramSource)) {
            return false;
        }
        ProgramSource other = (ProgramSource) object;
        return !((this.id == null && other.id != null) ||
                 (this.id != null && !this.id.equals(other.id)));
    }

    /**
     * Retrieve a string representation of this instance.
     *
     * @return A string representation of this instance.
     */
    @Override
    public String toString() {
        return "nl.robominer.entity.ProgramSource[ id=" + id + " ]";
    }
}
