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
        hideElements(document.getElementsByName('robotPartTypeRow' + prevRobotPartTypeId));
        var robotPartTypeId = document.getElementById('robotPartTypeId').value;
        showElements(document.getElementsByName('robotPartTypeRow' + robotPartTypeId));
        document.getElementById('selectedRobotPartTypeId').value = robotPartTypeId;
    }
    function buyItem(robotPartId, robotPartName) {
        if (confirm("Buy '" + robotPartName + "'?")) {
            document.getElementById('buyRobotPartId').value = robotPartId;
            document.getElementById('buyRobotPartForm').submit();
        }
    }
</script>
<form id="buyRobotPartForm" action="<c:url value='shop'/>" method="post">
    <input type="hidden" id="buyRobotPartId" name="buyRobotPartId" value=""/>
    <input type="hidden" id="selectedRobotPartTypeId" name="selectedRobotPartTypeId" value="${selectedRobotPartTypeId}"/>
</form>
<h1>Shop</h1>
Category:
<select id="robotPartTypeId" onchange="showRobotParts();">
    <c:forEach var="robotPartType" items="${robotPartMap}">
        <option value="${robotPartType.key.id}" ${robotPartType.key.id eq selectedRobotPartTypeId ? 'selected="selected"' : ''}>${fn:escapeXml(robotPartType.key.typeName)}</option>
    </c:forEach>
</select>
<h2>Items:</h2>
<table>
    <c:forEach var="robotPartType" items="${robotPartMap}">
        <c:forEach var="robotPart" items="${robotPartType.value}">
            <tr name="robotPartTypeRow${robotPartType.key.id}" style="display: none">
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
                    <tr name="robotPartTypeRow${robotPartType.key.id}" style="display: none">
                        <td>Ore capacity:</td>
                        <td colspan="2">${robotPart.oreCapacity}</td>
                    </tr>
                </c:when>
                <c:when test="${robotPartType.key.id eq 3}">
                    <tr name="robotPartTypeRow${robotPartType.key.id}" style="display: none">
                        <td>Battery capacity:</td>
                        <td colspan="2">${robotPart.batteryCapacity}</td>
                    </tr>
                </c:when>
            </c:choose>
            <tr name="robotPartTypeRow${robotPartType.key.id}" style="display: none">
                <td>Ore cost:</td>
            </tr>
            <c:forEach var="orePrice" items="${robotPart.orePrice.orePriceAmountList}">
                <tr name="robotPartTypeRow${robotPartType.key.id}" style="display: none">
                    <td></td>
                    <td>${fn:escapeXml(orePrice.ore.oreName)}:</td>
                    <td>${orePrice.amount}</td>
                    <td class="${user.getUserOreAmount(orePrice.ore.id) ge orePrice.amount ? 'sufficientbalance' : 'insufficientbalance'}">(${user.getUserOreAmount(orePrice.ore.id)})</td>
                </tr>
            </c:forEach>
            <tr name="robotPartTypeRow${robotPartType.key.id}" style="display: none">
                <td>Owned:</td>
                <td>${user.getRobotPartAmount(robotPart.id)}</td>
            </tr>
            <tr name="robotPartTypeRow${robotPartType.key.id}" style="display: none">
                <td><p></p></td>
            </tr>
        </c:forEach>
    </c:forEach>
</table>
<script>
    showRobotParts();
</script>