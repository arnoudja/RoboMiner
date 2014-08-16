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
<script>
    function getAvailableMemory(robotId) {
        var memoryModuleId = document.getElementById('memoryModuleId' + robotId).value;
        
        return Number(document.getElementById('memoryModuleSize' + memoryModuleId).value);
    }
    function getUsedMemory(robotId) {
        var programSourceId = document.getElementById('programSourceId' + robotId).value;
        
        return Number(document.getElementById('programSize' + programSourceId).value);
    }
    function updateMemorySizes() {
        var robotId = document.getElementById('robotId').value;
        var availableMemory = getAvailableMemory(robotId);
        var usedMemory = getUsedMemory(robotId);
        
        document.getElementById('memoryParameters' + robotId).value = usedMemory + '/' + availableMemory;
        document.getElementById('memoryParameters' + robotId).className = (availableMemory >= usedMemory ? 'valid' : 'invalid');
    }
    function showRobotDetails() {
        var prevRobotId = document.getElementById('prevRobotId').value;
        hideElements(document.getElementsByName('robotRow' + prevRobotId));
        var robotId = document.getElementById('robotId').value;
        showElements(document.getElementsByName('robotRow' + robotId));
        document.getElementById('prevRobotId').value = robotId;
        updateMemorySizes();
    }
    function applyChanges() {
        var robotId = document.getElementById('robotId').value;
        var availableMemory = getAvailableMemory(robotId);
        var usedMemory = getUsedMemory(robotId);
        var robotName = document.getElementById('robotName' + robotId).value;
        var robotNameRegExp = new RegExp('^[A-Za-z0-9_]{1,10}$');
        
        if (!robotNameRegExp.test(robotName)) {
            alert("Invalid robot name.");
        }
        else if (usedMemory > availableMemory) {
            alert("Not enough memory available!");
        }
        else {
            document.getElementById('robotForm').submit();
        }
    }
</script>
<h1>Robots</h1>
<form id="robotForm" action="<c:url value='robot'/>" method="post">
    <input type="hidden" id="prevRobotId" value="${robotId}"/>
    <c:forEach var="memoryModule" items="${memoryModuleMap}">
        <input type="hidden" id="memoryModuleSize${memoryModule.key}" value="${memoryModule.value.memoryCapacity}"/>
    </c:forEach>
    <c:forEach var='programSource' items="${programSourceMap}">
        <input type="hidden" id="programSize${programSource.key}" value="${programSource.value.compiledSize}"/>
    </c:forEach>
    <table>
        <tr>
            <td>Robot:</td>
            <td>
                <select id='robotId' name="robotId" class="selectiontableselect" onchange='showRobotDetails();'>
                    <c:forEach var='robot' items='${robotList}'>
                        <option value="${robot.id}" ${robot.id eq robotId ? 'selected="selected"' : ''}>${fn:escapeXml(robot.robotName)}</option>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <c:forEach var='robot' items='${robotList}'>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>Name:</td>
                <td>
                    <input type="text" id="robotName${robot.id}" name="robotName${robot.id}" value="${fn:escapeXml(robot.robotName)}" size="40" pattern="[A-Za-z0-9_]{1,10}" required />
                </td>
                <td>1 to 10 characters, only letters and numbers</td>
            </tr>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>Sourcecode:</td>
                <td>
                    <select id="programSourceId${robot.id}" name="programSourceId${robot.id}" class="selectiontableselect" onchange="updateMemorySizes();">
                        <c:forEach var='programSource' items="${programSourceMap}">
                            <option value="${programSource.key}" ${robot.programSourceId eq programSource.key ? 'selected="selected"' : ''}>${fn:escapeXml(programSource.value.sourceName)}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>Ore container:</td>
                <td>
                    <select name="oreContainerId${robot.id}" class="selectiontableselect">
                        <option value="${robot.oreContainer.id}" selected="selected">${fn:escapeXml(robot.oreContainer.partName)}</option>
                        <c:forEach var='oreContainer' items="${oreContainerList}">
                            <c:if test="${oreContainer.amount gt 0 and oreContainer.userRobotPartAssetPK.robotPartId ne robot.oreContainer.id}">
                                <option value="${oreContainer.userRobotPartAssetPK.robotPartId}">${fn:escapeXml(oreContainer.robotPart.partName)}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>Mining unit:</td>
                <td>
                    <select name="miningUnitId${robot.id}" class="selectiontableselect">
                        <option value="${robot.miningUnit.id}" selected="selected">${fn:escapeXml(robot.miningUnit.partName)}</option>
                        <c:forEach var='miningUnit' items="${miningUnitList}">
                            <c:if test="${miningUnit.amount gt 0 and miningUnit.userRobotPartAssetPK.robotPartId ne robot.miningUnit.id}">
                                <option value="${miningUnit.userRobotPartAssetPK.robotPartId}">${fn:escapeXml(miningUnit.robotPart.partName)}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>Battery:</td>
                <td>
                    <select name="batteryId${robot.id}" class="selectiontableselect">
                        <option value="${robot.battery.id}" selected="selected">${fn:escapeXml(robot.battery.partName)}</option>
                        <c:forEach var='battery' items="${batteryList}">
                            <c:if test="${battery.amount gt 0 and battery.userRobotPartAssetPK.robotPartId ne robot.battery.id}">
                                <option value="${battery.userRobotPartAssetPK.robotPartId}">${fn:escapeXml(battery.robotPart.partName)}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>Memory module:</td>
                <td>
                    <select id="memoryModuleId${robot.id}" name="memoryModuleId${robot.id}" class="selectiontableselect" onchange="updateMemorySizes();">
                        <option value="${robot.memoryModule.id}" selected="selected">${fn:escapeXml(robot.memoryModule.partName)}</option>
                        <c:forEach var='memoryModule' items="${memoryModuleList}">
                            <c:if test="${memoryModule.amount gt 0 and memoryModule.userRobotPartAssetPK.robotPartId ne robot.memoryModule.id}">
                                <option value="${memoryModule.userRobotPartAssetPK.robotPartId}">${fn:escapeXml(memoryModule.robotPart.partName)}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>CPU:</td>
                <td>
                    <select name="cpuId${robot.id}" class="selectiontableselect">
                        <option value="${robot.cpu.id}" selected="selected">${fn:escapeXml(robot.cpu.partName)}</option>
                        <c:forEach var='cpu' items="${cpuList}">
                            <c:if test="${cpu.amount gt 0 and cpu.userRobotPartAssetPK.robotPartId ne robot.cpu.id}">
                                <option value="${cpu.userRobotPartAssetPK.robotPartId}">${fn:escapeXml(cpu.robotPart.partName)}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>Engine:</td>
                <td>
                    <select name="engineId${robot.id}" class="selectiontableselect">
                        <option value="${robot.engine.id}" selected="selected">${fn:escapeXml(robot.engine.partName)}</option>
                        <c:forEach var='engine' items="${engineList}">
                            <c:if test="${engine.amount gt 0 and engine.userRobotPartAssetPK.robotPartId ne robot.engine.id}">
                                <option value="${engine.userRobotPartAssetPK.robotPartId}">${fn:escapeXml(engine.robotPart.partName)}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>Ore capacity:</td>
                <td>
                    <input type="text" readonly="true" value="${robot.maxOre}" size="6"/>
                </td>
            </tr>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>Mining speed:</td>
                <td>
                    <input type="text" readonly="true" value="${robot.miningSpeed}" size="6"/>
                </td>
            </tr>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>Max. cycles:</td>
                <td>
                    <input type="text" readonly="true" value="${robot.maxTurns}" size="6"/>
                </td>
            </tr>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>Memory used/available:</td>
                <td>
                    <input type="text" readonly="true" id="memoryParameters${robot.id}" value="" size="6"/>
                </td>
            </tr>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>CPU speed:</td>
                <td>
                    <input type="text" readonly="true" value="${robot.cpuSpeed}" size="6"/>
                </td>
            </tr>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>Forward speed:</td>
                <td>
                    <input type="text" readonly="true" value="${robot.forwardSpeed}" size="6"/>
                </td>
            </tr>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>Backward speed:</td>
                <td>
                    <input type="text" readonly="true" value="${robot.backwardSpeed}" size="6"/>
                </td>
            </tr>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>Rotate speed:</td>
                <td>
                    <input type="text" readonly="true" value="${robot.rotateSpeed}" size="6"/>
                </td>
            </tr>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>Size:</td>
                <td>
                    <input type="text" readonly="true" value="${robot.robotSize}" size="6"/>
                </td>
            </tr>
            <tr name="robotRow${robot.id}" style="display: none">
                <td>Recharge time:</td>
                <td>
                    <input type="text" readonly="true" value="${robot.rechargeTime}" size="6"/>
                </td>
            </tr>
        </c:forEach>
    </table>
    <br>
    <c:if test="${not empty errorMessage}">
        <p>${fn:escapeXml(errorMessage)}</p>
        <br>
    </c:if>
</form>
<button onclick="applyChanges();">Apply</button>
<script>
    showRobotDetails();
</script>