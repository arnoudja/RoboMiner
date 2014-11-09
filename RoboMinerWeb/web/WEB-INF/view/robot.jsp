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

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/robominer.css">
        <script src='js/robominer.js'></script>
        <script src='js/robot.js'></script>
        <title>RoboMiner - Robot</title>
    </head>
    <body>
        <input type="hidden" id="prevRobotId" value="${robotId}"/>

        <c:forEach var="memoryModuleAsset" items="${user.getUserRobotPartAssetListOfType(4)}">
            <input type="hidden" id="memoryModuleSize${memoryModuleAsset.robotPart.id}" value="${memoryModuleAsset.robotPart.memoryCapacity}"/>
        </c:forEach>
        <c:forEach var='programSource' items="${user.programSourceList}">
            <input type="hidden" id="programSize${programSource.id}" value="${programSource.compiledSize}"/>
        </c:forEach>

        <rm:defaultpage currentform="robot" username="${user.username}">

            <form id="robotForm" action="<c:url value='robot'/>" method="post">
                <table>
                    <thead>
                        <tr>
                            <th>Robot:</th>
                            <th>
                                <select id='robotId' name="robotId" onchange='showRobotDetails();'>
                                    <c:forEach var='robot' items='${user.robotList}'>
                                        <option value="${robot.id}" ${robot.id eq robotId ? 'selected' : ''}>${fn:escapeXml(robot.robotName)}</option>
                                    </c:forEach>
                                </select>
                            </th>
                        </tr>
                    </thead>

                    <c:forEach var='robot' items='${user.robotList}'>
                        <tbody id="robotDetails${robot.id}" style="display: none">
                            <tr>
                                <td>Name:</td>
                                <td>
                                    <input type="text" id="robotName${robot.id}" name="robotName${robot.id}" value="${fn:escapeXml(robot.robotName)}" size="40" pattern="[A-Za-z0-9_]{1,15}" placeholder="1 to 15 characters, only letters and numbers" required />
                                </td>
                            </tr>
                            <tr>
                                <td>Source code:</td>
                                <td>
                                    <select id="programSourceId${robot.id}" name="programSourceId${robot.id}" class="tableitem" onchange="updateMemorySizes();">
                                        <c:forEach var='programSource' items="${user.programSourceList}">
                                            <option value="${programSource.id}" ${robot.programSourceId eq programSource.id ? 'selected="selected"' : ''}>${fn:escapeXml(programSource.sourceName)}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Ore container:</td>
                                <td>
                                    <select name="oreContainerId${robot.id}" class="tableitem">
                                        <option value="${robot.oreContainer.id}" selected="selected">${fn:escapeXml(robot.oreContainer.partName)}</option>
                                        <c:forEach var='oreContainerAsset' items="${user.getUserRobotPartAssetListOfType(1)}">
                                            <c:if test="${oreContainerAsset.unassigned gt 0 and oreContainerAsset.robotPart.id ne robot.oreContainer.id}">
                                                <option value="${oreContainerAsset.robotPart.id}">${fn:escapeXml(oreContainerAsset.robotPart.partName)}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Mining unit:</td>
                                <td>
                                    <select name="miningUnitId${robot.id}" class="tableitem">
                                        <option value="${robot.miningUnit.id}" selected="selected">${fn:escapeXml(robot.miningUnit.partName)}</option>
                                        <c:forEach var='miningUnitAsset' items="${user.getUserRobotPartAssetListOfType(2)}">
                                            <c:if test="${miningUnitAsset.unassigned gt 0 and miningUnitAsset.robotPart.id ne robot.miningUnit.id}">
                                                <option value="${miningUnitAsset.robotPart.id}">${fn:escapeXml(miningUnitAsset.robotPart.partName)}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Battery:</td>
                                <td>
                                    <select name="batteryId${robot.id}" class="tableitem">
                                        <option value="${robot.battery.id}" selected="selected">${fn:escapeXml(robot.battery.partName)}</option>
                                        <c:forEach var='batteryAsset' items="${user.getUserRobotPartAssetListOfType(3)}">
                                            <c:if test="${batteryAsset.unassigned gt 0 and batteryAsset.robotPart.id ne robot.battery.id}">
                                                <option value="${batteryAsset.robotPart.id}">${fn:escapeXml(batteryAsset.robotPart.partName)}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Memory module:</td>
                                <td>
                                    <select id="memoryModuleId${robot.id}" name="memoryModuleId${robot.id}" class="tableitem" onchange="updateMemorySizes();">
                                        <option value="${robot.memoryModule.id}" selected="selected">${fn:escapeXml(robot.memoryModule.partName)}</option>
                                        <c:forEach var='memoryModuleAsset' items="${user.getUserRobotPartAssetListOfType(4)}">
                                            <c:if test="${memoryModuleAsset.unassigned gt 0 and memoryModuleAsset.robotPart.id ne robot.memoryModule.id}">
                                                <option value="${memoryModuleAsset.robotPart.id}">${fn:escapeXml(memoryModuleAsset.robotPart.partName)}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>CPU:</td>
                                <td>
                                    <select name="cpuId${robot.id}" class="tableitem">
                                        <option value="${robot.cpu.id}" selected="selected">${fn:escapeXml(robot.cpu.partName)}</option>
                                        <c:forEach var='cpuAsset' items="${user.getUserRobotPartAssetListOfType(5)}">
                                            <c:if test="${cpuAsset.unassigned gt 0 and cpuAsset.robotPart.id ne robot.cpu.id}">
                                                <option value="${cpuAsset.robotPart.id}">${fn:escapeXml(cpuAsset.robotPart.partName)}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Engine:</td>
                                <td>
                                    <select name="engineId${robot.id}" class="tableitem">
                                        <option value="${robot.engine.id}" selected="selected">${fn:escapeXml(robot.engine.partName)}</option>
                                        <c:forEach var='engineAsset' items="${user.getUserRobotPartAssetListOfType(6)}">
                                            <c:if test="${engineAsset.unassigned gt 0 and engineAsset.robotPart.id ne robot.engine.id}">
                                                <option value="${engineAsset.robotPart.id}">${fn:escapeXml(engineAsset.robotPart.partName)}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Ore capacity:</td>
                                <td>${robot.maxOre} units</td>
                            </tr>
                            <tr>
                                <td>Mining speed:</td>
                                <td>${robot.miningSpeed} u/c</td>
                            </tr>
                            <tr>
                                <td>Max. cycles:</td>
                                <td>${robot.maxTurns} cycles</td>
                            </tr>
                            <tr>
                                <td>Memory used/available:</td>
                                <td id="memoryParameters${robot.id}"></td>
                            </tr>
                            <tr>
                                <td>CPU speed:</td>
                                <td>${robot.cpuSpeed} i/c</td>
                            </tr>
                            <tr>
                                <td>Forward speed:</td>
                                <td>
                                    <fmt:formatNumber value="${robot.forwardSpeed}" maxFractionDigits="2"/> s/c
                                </td>
                            </tr>
                            <tr>
                                <td>Backward speed:</td>
                                <td>
                                    <fmt:formatNumber value="${robot.backwardSpeed}" maxFractionDigits="2"/> s/c
                                </td>
                            </tr>
                            <tr>
                                <td>Rotate speed:</td>
                                <td>${robot.rotateSpeed} d/c</td>
                            </tr>
                            <tr>
                                <td>Size:</td>
                                <td>
                                    <fmt:formatNumber value="${robot.robotSize}" maxFractionDigits="2"/> s
                                </td>
                            </tr>
                            <tr>
                                <td>Recharge time:</td>
                                <td>
                                    <rm:formatperiod seconds="${robot.rechargeTime}"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="button">
                                    <c:choose>
                                        <c:when test="${robot.changePending}">
                                            Changes are pending for this robot.
                                        </c:when>
                                        <c:otherwise>
                                            <button onclick="applyChanges(${robot.id});">Apply</button>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
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
        </rm:defaultpage>

        <script>
            showRobotDetails();
        </script>
    </body>
</html>
