<!DOCTYPE html>
<%--
 Copyright (C) 2014 Arnoud Jagerman

 This file is part of RoboMiner.

 RoboMiner is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 RoboMiner is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="rm" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<rm:robominerheader>

    <script src='js/robot.js'></script>

    <input type="hidden" id="prevRobotId" value="${robotId}"/>

    <c:forEach var="memoryModule" items="${memoryModuleMap}">
        <input type="hidden" id="memoryModuleSize${memoryModule.key}" value="${memoryModule.value.memoryCapacity}"/>
    </c:forEach>
    <c:forEach var='programSource' items="${programSourceMap}">
        <input type="hidden" id="programSize${programSource.key}" value="${programSource.value.compiledSize}"/>
    </c:forEach>

    <rm:defaultpage currentform="robot">

        <form id="robotForm" action="<c:url value='robot'/>" method="post">
            <table>
                <thead>
                    <tr>
                        <th>Robot:</th>
                        <th colspan="3">
                            <select id='robotId' name="robotId" onchange='showRobotDetails();'>
                                <c:forEach var='robot' items='${robotList}'>
                                    <option value="${robot.id}" ${robot.id eq robotId ? 'selected' : ''}>${fn:escapeXml(robot.robotName)}</option>
                                </c:forEach>
                            </select>
                        </th>
                    </tr>
                </thead>

                <c:forEach var='robot' items='${robotList}'>
                    <tbody name="robotRow${robot.id}" style="display: none">
                        <tr>
                            <td>Name:</td>
                            <td colspan="3">
                                <input type="text" id="robotName${robot.id}" name="robotName${robot.id}" value="${fn:escapeXml(robot.robotName)}" size="40" pattern="[A-Za-z0-9_]{1,10}" placeholder="1 to 10 characters, only letters and numbers" required />
                            </td>
                        </tr>
                        <tr>
                            <td>Sourcecode:</td>
                            <td colspan="3">
                                <select id="programSourceId${robot.id}" name="programSourceId${robot.id}" class="tableitem" onchange="updateMemorySizes();">
                                    <c:forEach var='programSource' items="${programSourceMap}">
                                        <option value="${programSource.key}" ${robot.programSourceId eq programSource.key ? 'selected="selected"' : ''}>${fn:escapeXml(programSource.value.sourceName)}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Ore container:</td>
                            <td colspan="3">
                                <select name="oreContainerId${robot.id}" class="tableitem">
                                    <option value="${robot.oreContainer.id}" selected="selected">${fn:escapeXml(robot.oreContainer.partName)}</option>
                                    <c:forEach var='oreContainer' items="${oreContainerList}">
                                        <c:if test="${oreContainer.unassigned gt 0 and oreContainer.userRobotPartAssetPK.robotPartId ne robot.oreContainer.id}">
                                            <option value="${oreContainer.userRobotPartAssetPK.robotPartId}">${fn:escapeXml(oreContainer.robotPart.partName)}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Mining unit:</td>
                            <td colspan="3">
                                <select name="miningUnitId${robot.id}" class="tableitem">
                                    <option value="${robot.miningUnit.id}" selected="selected">${fn:escapeXml(robot.miningUnit.partName)}</option>
                                    <c:forEach var='miningUnit' items="${miningUnitList}">
                                        <c:if test="${miningUnit.unassigned gt 0 and miningUnit.userRobotPartAssetPK.robotPartId ne robot.miningUnit.id}">
                                            <option value="${miningUnit.userRobotPartAssetPK.robotPartId}">${fn:escapeXml(miningUnit.robotPart.partName)}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Battery:</td>
                            <td colspan="3">
                                <select name="batteryId${robot.id}" class="tableitem">
                                    <option value="${robot.battery.id}" selected="selected">${fn:escapeXml(robot.battery.partName)}</option>
                                    <c:forEach var='battery' items="${batteryList}">
                                        <c:if test="${battery.unassigned gt 0 and battery.userRobotPartAssetPK.robotPartId ne robot.battery.id}">
                                            <option value="${battery.userRobotPartAssetPK.robotPartId}">${fn:escapeXml(battery.robotPart.partName)}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Memory module:</td>
                            <td colspan="3">
                                <select id="memoryModuleId${robot.id}" name="memoryModuleId${robot.id}" class="tableitem" onchange="updateMemorySizes();">
                                    <option value="${robot.memoryModule.id}" selected="selected">${fn:escapeXml(robot.memoryModule.partName)}</option>
                                    <c:forEach var='memoryModule' items="${memoryModuleList}">
                                        <c:if test="${memoryModule.unassigned gt 0 and memoryModule.userRobotPartAssetPK.robotPartId ne robot.memoryModule.id}">
                                            <option value="${memoryModule.userRobotPartAssetPK.robotPartId}">${fn:escapeXml(memoryModule.robotPart.partName)}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>CPU:</td>
                            <td colspan="3">
                                <select name="cpuId${robot.id}" class="tableitem">
                                    <option value="${robot.cpu.id}" selected="selected">${fn:escapeXml(robot.cpu.partName)}</option>
                                    <c:forEach var='cpu' items="${cpuList}">
                                        <c:if test="${cpu.unassigned gt 0 and cpu.userRobotPartAssetPK.robotPartId ne robot.cpu.id}">
                                            <option value="${cpu.userRobotPartAssetPK.robotPartId}">${fn:escapeXml(cpu.robotPart.partName)}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Engine:</td>
                            <td colspan="3">
                                <select name="engineId${robot.id}" class="tableitem">
                                    <option value="${robot.engine.id}" selected="selected">${fn:escapeXml(robot.engine.partName)}</option>
                                    <c:forEach var='engine' items="${engineList}">
                                        <c:if test="${engine.unassigned gt 0 and engine.userRobotPartAssetPK.robotPartId ne robot.engine.id}">
                                            <option value="${engine.userRobotPartAssetPK.robotPartId}">${fn:escapeXml(engine.robotPart.partName)}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Ore capacity:</td>
                            <td>${robot.maxOre}</td>
                            <td colspan="2">units</td>
                        </tr>
                        <tr>
                            <td>Mining speed:</td>
                            <td>${robot.miningSpeed}</td>
                            <td colspan="2">upc</td>
                        </tr>
                        <tr>
                            <td>Max. cycles:</td>
                            <td>${robot.maxTurns}</td>
                            <td colspan="2">cycles</td>
                        </tr>
                        <tr>
                            <td>Memory used/available:</td>
                            <td colspan="3" id="memoryParameters${robot.id}"></td>
                        </tr>
                        <tr>
                            <td>CPU speed:</td>
                            <td>${robot.cpuSpeed}</td>
                            <td colspan="2">ipc</td>
                        </tr>
                        <tr>
                            <td>Forward speed:</td>
                            <td>
                                <fmt:formatNumber value="${robot.forwardSpeed}" maxFractionDigits="2"/>
                            </td>
                            <td colspan="2">upc</td>
                        </tr>
                        <tr>
                            <td>Backward speed:</td>
                            <td>
                                <fmt:formatNumber value="${robot.backwardSpeed}" maxFractionDigits="2"/>
                            </td>
                            <td colspan="2">upc</td>
                        </tr>
                        <tr>
                            <td>Rotate speed:</td>
                            <td>${robot.rotateSpeed}</td>
                            <td colspan="2">dpc</td>
                        </tr>
                        <tr>
                            <td>Size:</td>
                            <td colspan="3">
                                <fmt:formatNumber value="${robot.robotSize}" maxFractionDigits="2"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Recharge time:</td>
                            <td>${robot.rechargeTime}</td>
                            <td colspan="2">seconds</td>
                        </tr>
                    </tbody>
                </c:forEach>
            </table>
            <br>
            <c:if test="${not empty errorMessage}">
                <p class="error">${fn:escapeXml(errorMessage)}</p>
                <br>
            </c:if>
        </form>
        <button onclick="applyChanges();">Apply</button>

    </rm:defaultpage>

    <script>
        showRobotDetails();
    </script>

</rm:robominerheader>
