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
import java.math.BigDecimal;
import java.math.BigInteger;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
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
@Table(name = "TopRobotsView")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TopRobotsView.findAll", query = "SELECT t FROM TopRobotsView t"),
    @NamedQuery(name = "TopRobotsView.findTopRobots", query = "SELECT t FROM TopRobotsView t ORDER BY t.orePerRun DESC")})
public class TopRobotsView implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Basic(optional = false)
    @Column(name = "robotId")
    private Integer robotId;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "robotName")
    private String robotName;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "username")
    private String username;

    @Basic(optional = false)
    @NotNull
    @Column(name = "totalRuns")
    private long totalRuns;

    @Column(name = "totalAmount")
    private BigInteger totalAmount;

    @Column(name = "orePerRun")
    private BigDecimal orePerRun;

    public TopRobotsView() {
    }

    public int getRobotId() {
        return robotId;
    }

    public String getRobotName() {
        return robotName;
    }

    public String getUsername() {
        return username;
    }

    public long getTotalRuns() {
        return totalRuns;
    }

    public BigInteger getTotalAmount() {
        return totalAmount;
    }

    public BigDecimal getOrePerRun() {
        return orePerRun;
    }

}
