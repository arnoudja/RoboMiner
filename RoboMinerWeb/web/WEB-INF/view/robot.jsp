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
                            <th colspan="2">
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
                                <td colspan="2">
                                    <input type="text" id="robotName${robot.id}" name="robotName${robot.id}" value="${fn:escapeXml(robot.robotName)}" size="40" pattern="[A-Za-z0-9_]{1,10}" placeholder="1 to 10 characters, only letters and numbers" required />
                                </td>
                            </tr>
                            <tr>
                                <td>Sourcecode:</td>
                                <td colspan="2">
                                    <select id="programSourceId${robot.id}" name="programSourceId${robot.id}" class="tableitem" onchange="updateMemorySizes();">
                                        <c:forEach var='programSource' items="${user.programSourceList}">
                                            <option value="${programSource.id}" ${robot.programSourceId eq programSource.id ? 'selected="selected"' : ''}>${fn:escapeXml(programSource.sourceName)}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Ore container:</td>
                                <td colspan="2">
                                    <select name="oreContainerId${robot.id}" class="tableitem">
                                        <option value="${robot.oreContainer.id}" selected="selected">${fn:escapeXml(robot.oreContainer.partName)}</option>
                                        <c:forEach var='oreContainer' items="${user.getUserRobotPartAssetListOfType(1)}">
                                            <c:if test="${oreContainer.unassigned gt 0 and oreContainer.userRobotPartAssetPK.robotPartId ne robot.oreContainer.id}">
                                                <option value="${oreContainer.userRobotPartAssetPK.robotPartId}">${fn:escapeXml(oreContainer.robotPart.partName)}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Mining unit:</td>
                                <td colspan="2">
                                    <select name="miningUnitId${robot.id}" class="tableitem">
                                        <option value="${robot.miningUnit.id}" selected="selected">${fn:escapeXml(robot.miningUnit.partName)}</option>
                                        <c:forEach var='miningUnit' items="${user.getUserRobotPartAssetListOfType(2)}">
                                            <c:if test="${miningUnit.unassigned gt 0 and miningUnit.userRobotPartAssetPK.robotPartId ne robot.miningUnit.id}">
                                                <option value="${miningUnit.userRobotPartAssetPK.robotPartId}">${fn:escapeXml(miningUnit.robotPart.partName)}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Battery:</td>
                                <td colspan="2">
                                    <select name="batteryId${robot.id}" class="tableitem">
                                        <option value="${robot.battery.id}" selected="selected">${fn:escapeXml(robot.battery.partName)}</option>
                                        <c:forEach var='battery' items="${user.getUserRobotPartAssetListOfType(3)}">
                                            <c:if test="${battery.unassigned gt 0 and battery.userRobotPartAssetPK.robotPartId ne robot.battery.id}">
                                                <option value="${battery.userRobotPartAssetPK.robotPartId}">${fn:escapeXml(battery.robotPart.partName)}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Memory module:</td>
                                <td colspan="2">
                                    <select id="memoryModuleId${robot.id}" name="memoryModuleId${robot.id}" class="tableitem" onchange="updateMemorySizes();">
                                        <option value="${robot.memoryModule.id}" selected="selected">${fn:escapeXml(robot.memoryModule.partName)}</option>
                                        <c:forEach var='memoryModule' items="${user.getUserRobotPartAssetListOfType(4)}">
                                            <c:if test="${memoryModule.unassigned gt 0 and memoryModule.userRobotPartAssetPK.robotPartId ne robot.memoryModule.id}">
                                                <option value="${memoryModule.userRobotPartAssetPK.robotPartId}">${fn:escapeXml(memoryModule.robotPart.partName)}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>CPU:</td>
                                <td colspan="2">
                                    <select name="cpuId${robot.id}" class="tableitem">
                                        <option value="${robot.cpu.id}" selected="selected">${fn:escapeXml(robot.cpu.partName)}</option>
                                        <c:forEach var='cpu' items="${user.getUserRobotPartAssetListOfType(5)}">
                                            <c:if test="${cpu.unassigned gt 0 and cpu.userRobotPartAssetPK.robotPartId ne robot.cpu.id}">
                                                <option value="${cpu.userRobotPartAssetPK.robotPartId}">${fn:escapeXml(cpu.robotPart.partName)}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Engine:</td>
                                <td colspan="2">
                                    <select name="engineId${robot.id}" class="tableitem">
                                        <option value="${robot.engine.id}" selected="selected">${fn:escapeXml(robot.engine.partName)}</option>
                                        <c:forEach var='engine' items="${user.getUserRobotPartAssetListOfType(6)}">
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
                                <td>units</td>
                            </tr>
                            <tr>
                                <td>Mining speed:</td>
                                <td>${robot.miningSpeed}</td>
                                <td>upc</td>
                            </tr>
                            <tr>
                                <td>Max. cycles:</td>
                                <td>${robot.maxTurns}</td>
                                <td>cycles</td>
                            </tr>
                            <tr>
                                <td>Memory used/available:</td>
                                <td colspan="2" id="memoryParameters${robot.id}"></td>
                            </tr>
                            <tr>
                                <td>CPU speed:</td>
                                <td>${robot.cpuSpeed}</td>
                                <td>ipc</td>
                            </tr>
                            <tr>
                                <td>Forward speed:</td>
                                <td>
                                    <fmt:formatNumber value="${robot.forwardSpeed}" maxFractionDigits="2"/>
                                </td>
                                <td>upc</td>
                            </tr>
                            <tr>
                                <td>Backward speed:</td>
                                <td>
                                    <fmt:formatNumber value="${robot.backwardSpeed}" maxFractionDigits="2"/>
                                </td>
                                <td>upc</td>
                            </tr>
                            <tr>
                                <td>Rotate speed:</td>
                                <td>${robot.rotateSpeed}</td>
                                <td>dpc</td>
                            </tr>
                            <tr>
                                <td>Size:</td>
                                <td colspan="2">
                                    <fmt:formatNumber value="${robot.robotSize}" maxFractionDigits="2"/>
                                </td>
                            </tr>
                            <tr>
                                <td>Recharge time:</td>
                                <td>${robot.rechargeTime}</td>
                                <td>seconds</td>
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
    </body>
</html>
