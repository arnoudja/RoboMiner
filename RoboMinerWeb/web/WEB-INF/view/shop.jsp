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
    function showRobotParts() {
        var prevRobotPartTypeId = document.getElementById('selectedRobotPartTypeId').value;
        var prevTierId = document.getElementById('selectedTierId').value;
        hideElements(document.getElementsByName('robotPartTypeRow' + prevRobotPartTypeId + '_' + prevTierId));
        var robotPartTypeId = document.getElementById('robotPartTypeId').value;
        var tierId = document.getElementById('tierId').value;
        showElements(document.getElementsByName('robotPartTypeRow' + robotPartTypeId + '_' + tierId));
        document.getElementById('selectedRobotPartTypeId').value = robotPartTypeId;
        document.getElementById('selectedTierId').value = tierId;
    }
    function buyItem(robotPartId, robotPartName) {
        if (confirm("Buy '" + robotPartName + "'?")) {
            document.getElementById('buyRobotPartId').value = robotPartId;
            document.getElementById('buySellRobotPartForm').submit();
        }
    }
    function sellItem(robotPartId, robotPartName) {
        if (confirm("Selling will return half the original price. Sell '" + robotPartName + "'?")) {
            document.getElementById('sellRobotPartId').value = robotPartId;
            document.getElementById('buySellRobotPartForm').submit();
        }
    }
</script>
<form id="buySellRobotPartForm" action="<c:url value='shop'/>" method="post">
    <input type="hidden" id="buyRobotPartId" name="buyRobotPartId" value=""/>
    <input type="hidden" id="sellRobotPartId" name="sellRobotPartId" value=""/>
    <input type="hidden" id="selectedRobotPartTypeId" name="selectedRobotPartTypeId" value="${selectedRobotPartTypeId}"/>
    <input type="hidden" id="selectedTierId" name="selectedTierId" value="${selectedTierId}"/>
</form>
<h1>Shop</h1>
Category:
<select id="robotPartTypeId" onchange="showRobotParts();">
    <c:forEach var="robotPartType" items="${robotPartMap}">
        <option value="${robotPartType.key.id}" ${robotPartType.key.id eq selectedRobotPartTypeId ? 'selected="selected"' : ''}>${fn:escapeXml(robotPartType.key.typeName)}</option>
    </c:forEach>
</select>
Tier:
<select id="tierId" onchange="showRobotParts();">
    <c:forEach var="tier" items="${tierList}">
        <option value="${tier.id}" ${tier.id eq selectedTierId ? 'selected="selected"' : ''}>${fn:escapeXml(tier.tierName)}</option>
    </c:forEach>
</select>
<h2>Items:</h2>
<table>
    <c:forEach var="robotPartType" items="${robotPartMap}">
        <c:forEach var="robotPart" items="${robotPartType.value}">
            <tbody name="robotPartTypeRow${robotPartType.key.id}_${robotPart.tierId}" style="display: none">
                <tr>
                    <td>Part name:</td>
                    <td colspan="2">${fn:escapeXml(robotPart.partName)}</td>
                    <c:if test="${user.canAffort(robotPart.orePrice)}">
                        <td>
                            <button onclick="buyItem(${robotPart.id}, '${fn:escapeXml(robotPart.partName)}');">Buy</button>
                        </td>
                    </c:if>
                </tr>
                <c:choose>
                    <c:when test="${robotPartType.key.id eq 1}">
                        <tr>
                            <td>Ore capacity:</td>
                            <td colspan="2">${robotPart.oreCapacity}</td>
                        </tr>
                    </c:when>
                    <c:when test="${robotPartType.key.id eq 3}">
                        <tr>
                            <td>Battery capacity:</td>
                            <td colspan="2">${robotPart.batteryCapacity}</td>
                        </tr>
                    </c:when>
                </c:choose>
                <c:if test="${robotPart.powerUsage gt 0}">
                    <tr>
                        <td>Power consumption:</td>
                        <td colspan="2">${robotPart.powerUsage}</td>
                    </tr>
                </c:if>
                <tr>
                    <td>Ore cost:</td>
                </tr>
                <c:forEach var="orePrice" items="${robotPart.orePrice.orePriceAmountList}">
                    <tr>
                        <td></td>
                        <td>${fn:escapeXml(orePrice.ore.oreName)}:</td>
                        <td>${orePrice.amount}</td>
                        <td class="${user.getUserOreAmount(orePrice.ore.id) ge orePrice.amount ? 'sufficientbalance' : 'insufficientbalance'}">(${user.getUserOreAmount(orePrice.ore.id)})</td>
                    </tr>
                </c:forEach>
                <c:if test="${user.getTotalRobotPartAmount(robotPart.id) gt 0}">
                    <tr>
                        <td>Owned/unassigned:</td>
                        <td colspan="2">${user.getTotalRobotPartAmount(robotPart.id)}/${user.getUnassignedRobotPartAmount(robotPart.id)}</td>
                        <c:if test="${user.getUnassignedRobotPartAmount(robotPart.id) gt 0}">
                            <td>
                                <button onclick="sellItem(${robotPart.id}, '${fn:escapeXml(robotPart.partName)}');">Sell</button>
                            </td>
                        </c:if>
                    </tr>
                </c:if>
                <tr>
                    <td><p></p></td>
                </tr>
            </tbody>
        </c:forEach>
    </c:forEach>
</table>
<script>
    showRobotParts();
</script>