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
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Arnoud Jagerman
 */
@Entity
@Table(name = "ProgramSource")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ProgramSource.findAll", query = "SELECT p FROM ProgramSource p"),
    @NamedQuery(name = "ProgramSource.findById", query = "SELECT p FROM ProgramSource p WHERE p.id = :id"),
    @NamedQuery(name = "ProgramSource.findByIdAndUser", query = "SELECT p FROM ProgramSource p WHERE p.id = :id AND p.usersId = :usersId"),
    @NamedQuery(name = "ProgramSource.findByUsersId", query = "SELECT p FROM ProgramSource p WHERE p.usersId = :usersId")})
public class ProgramSource implements Serializable {
    
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
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "sourceName")
    private String sourceName;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "verified")
    private boolean verified;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "compiledSize")
    private int compiledSize;
    
    @Size(max = 255)
    @Column(name = "errorDescription")
    private String errorDescription;
    
    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 65535)
    @Column(name = "sourceCode")
    private String sourceCode;

    public ProgramSource() {
    }

    public Integer getId() {
        return id;
    }

    public int getUsersId() {
        return usersId;
    }

    public void setUsersId(int usersId) {
        this.usersId = usersId;
    }
    
    public String getSourceName() {
        return sourceName;
    }

    public void setSourceName(String sourceName) {
        this.sourceName = sourceName;
    }

    public boolean getVerified() {
        return verified;
    }

    public void setVerified(boolean verified) {
        this.verified = verified;
    }

    public int getCompiledSize() {
        return compiledSize;
    }
    
    public void setCompiledSize(int compiledSize) {
        this.compiledSize = compiledSize;
    }
    
    public String getErrorDescription() {
        return errorDescription;
    }

    public void setErrorDescription(String errorDescription) {
        this.errorDescription = errorDescription;
    }

    public String getSourceCode() {
        return sourceCode;
    }

    public void setSourceCode(String sourceCode) {
        this.sourceCode = sourceCode;
    }

    public void fillDefaults() {

        setVerified(true);
        setCompiledSize(-1);
        setErrorDescription("");
        setSourceCode("move(1);\nmine();");
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
        if (!(object instanceof ProgramSource)) {
            return false;
        }
        ProgramSource other = (ProgramSource) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "nl.robominer.entity.ProgramSource[ id=" + id + " ]";
    }
}
