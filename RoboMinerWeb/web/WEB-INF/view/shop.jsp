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

<script src='js/shop.js'></script>

<rm:userassets oreassetlist='${oreAssetList}' />

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
<table class="shop">
    <c:forEach var="robotPartType" items="${robotPartMap}">
        <c:forEach var="robotPart" items="${robotPartType.value}">
            <tbody class="shop" name="robotPartTypeRow${robotPartType.key.id}_${robotPart.tierId}">
                <tr>
                    <td class="shopFirstRow">Part name:</td>
                    <td class="shopPartName" colspan="3">${fn:escapeXml(robotPart.partName)}</td>
                    <td class="shopFirstRow">
                        <c:if test="${user.canAffort(robotPart.orePrice) && user.robots.size() gt user.getTotalRobotPartAmount(robotPart.id)}">
                                <button onclick="buyItem(${robotPart.id}, '${fn:escapeXml(robotPart.partName)}');">Buy</button>
                        </c:if>
                    </td>
                </tr>
                <c:if test="${user.getTotalRobotPartAmount(robotPart.id) gt 0}">
                    <tr>
                        <td class="shopImportant">Owned:</td>
                        <td class="shop">${user.getTotalRobotPartAmount(robotPart.id)}/${user.getUnassignedRobotPartAmount(robotPart.id)}</td>
                        <td class="shop" colspan="2">total/unused</td>
                        <td class="shop">
                            <c:if test="${user.getUnassignedRobotPartAmount(robotPart.id) gt 0}">
                                <button onclick="sellItem(${robotPart.id}, '${fn:escapeXml(robotPart.partName)}');">Sell</button>
                            </c:if>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${robotPart.oreCapacity gt 0}">
                    <tr>
                        <td class="shop">Ore capacity:</td>
                        <td class="shop">${robotPart.oreCapacity}</td>
                        <td class="shop">units</td>
                        <td class="shop" colspan="2"></td>
                    </tr>
                </c:if>
                <c:if test="${robotPart.miningCapacity gt 0}">
                    <tr>
                        <td class="shop">Mining capacity:</td>
                        <td class="shop">${robotPart.miningCapacity}</td>
                        <td class="shop">upc</td>
                        <td class="shop" colspan="2"></td>
                    </tr>
                </c:if>
                <c:if test="${robotPart.batteryCapacity gt 0}">
                    <tr>
                        <td class="shop">Battery capacity:</td>
                        <td class="shop">${robotPart.batteryCapacity}</td>
                        <td class="shop" colspan="3"></td>
                    </tr>
                </c:if>
                <c:if test="${robotPart.memoryCapacity gt 0}">
                    <tr>
                        <td class="shop">Memory size:</td>
                        <td class="shop">${robotPart.memoryCapacity}</td>
                        <td class="shop" colspan="3"></td>
                    </tr>
                </c:if>
                <c:if test="${robotPart.cpuCapacity gt 0}">
                    <tr>
                        <td class="shop">CPU speed:</td>
                        <td class="shop">${robotPart.cpuCapacity}</td>
                        <td class="shop">ipc</td>
                        <td class="shop" colspan="2"></td>
                    </tr>
                </c:if>
                <c:if test="${robotPart.forwardCapacity gt 0}">
                    <tr>
                        <td class="shop">Engine power:</td>
                        <td class="shop">${robotPart.forwardCapacity}/${robotPart.backwardCapacity}/${robotPart.rotateCapacity}</td>
                        <td class="shop" colspan="2">fwd/bkwd/rot</td>
                        <td class="shop"></td>
                    </tr>
                </c:if>
                <c:if test="${robotPart.powerUsage gt 0}">
                    <tr>
                        <td class="shop">Power consumption:</td>
                        <td class="shop">${robotPart.powerUsage}</td>
                        <td class="shop" colspan="3"></td>
                    </tr>
                </c:if>
                <c:if test="${robotPart.rechargeTime gt 0}">
                    <tr>
                        <td class="shop">Recharge time:</td>
                        <td class="shop">${robotPart.rechargeTime}</td>
                        <td class="shop">seconds</td>
                        <td class="shop" colspan="2"></td>
                    </tr>
                </c:if>
                <c:if test="${robotPart.weight gt 0}">
                    <tr>
                        <td class="shop">Weight:</td>
                        <td class="shop">${robotPart.weight}</td>
                        <td class="shop" colspan="3"></td>
                    </tr>
                </c:if>
                <tr>
                    <td class="shop" colspan="5">Ore cost:</td>
                </tr>
                <c:forEach var="orePrice" items="${robotPart.orePrice.orePriceAmountList}">
                    <tr>
                        <td class="shop"></td>
                        <td class="shop" colspan="2">${fn:escapeXml(orePrice.ore.oreName)}:</td>
                        <td class="shop">${orePrice.amount}</td>
                        <td class="${user.getUserOreAmount(orePrice.ore.id) ge orePrice.amount ? 'shopSufficientBalance' : 'shopInsufficientBalance'}">(${user.getUserOreAmount(orePrice.ore.id)})</td>
                    </tr>
                </c:forEach>
                <tr class="shopLastRow">
                    <td colspan="5"></td>
                </tr>
            </tbody>
        </c:forEach>
    </c:forEach>
</table>

<form id="buySellRobotPartForm" action="<c:url value='shop'/>" method="post">
    <input type="hidden" id="buyRobotPartId" name="buyRobotPartId" value=""/>
    <input type="hidden" id="sellRobotPartId" name="sellRobotPartId" value=""/>
    <input type="hidden" id="selectedRobotPartTypeId" name="selectedRobotPartTypeId" value="${selectedRobotPartTypeId}"/>
    <input type="hidden" id="selectedTierId" name="selectedTierId" value="${selectedTierId}"/>
</form>

<script>showRobotParts();</script>
