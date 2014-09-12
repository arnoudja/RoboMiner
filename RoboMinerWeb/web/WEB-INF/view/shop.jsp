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
<%@ taglib prefix="rm" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<rm:robominerheader>

    <script src='js/shop.js'></script>

    <rm:defaultpage currentform="shop">

        <rm:userassets oreassetlist='${oreAssetList}' />

        <table>
            <tr>
                <td>Category:</td>
                <td>
                    <select id="robotPartTypeId" class="tableitem" onchange="showRobotParts();">
                        <c:forEach var="robotPartType" items="${robotPartMap}">
                            <option value="${robotPartType.key.id}" ${robotPartType.key.id eq selectedRobotPartTypeId ? 'selected' : ''}>${fn:escapeXml(robotPartType.key.typeName)}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Tier:</td>
                <td>
                    <select id="tierId" class="tableitem" onchange="showRobotParts();">
                        <c:forEach var="tier" items="${tierList}">
                            <option value="${tier.id}" ${tier.id eq selectedTierId ? 'selected' : ''}>${fn:escapeXml(tier.tierName)}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
        </table>

        <br><br>
        
        <table>
            <caption>Shop items</caption>
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
                                <td>${user.getTotalRobotPartAmount(robotPart.id)}/${user.getUnassignedRobotPartAmount(robotPart.id)}</td>
                                <td colspan="2">total/unused</td>
                                <td>
                                    <c:if test="${user.getUnassignedRobotPartAmount(robotPart.id) gt 0}">
                                        <button onclick="sellItem(${robotPart.id}, '${fn:escapeXml(robotPart.partName)}');">Sell</button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${robotPart.oreCapacity gt 0}">
                            <tr>
                                <td>Ore capacity:</td>
                                <td>${robotPart.oreCapacity}</td>
                                <td>units</td>
                                <td colspan="2"></td>
                            </tr>
                        </c:if>
                        <c:if test="${robotPart.miningCapacity gt 0}">
                            <tr>
                                <td>Mining capacity:</td>
                                <td>${robotPart.miningCapacity}</td>
                                <td>upc</td>
                                <td colspan="2"></td>
                            </tr>
                        </c:if>
                        <c:if test="${robotPart.batteryCapacity gt 0}">
                            <tr>
                                <td>Battery capacity:</td>
                                <td>${robotPart.batteryCapacity}</td>
                                <td colspan="3"></td>
                            </tr>
                        </c:if>
                        <c:if test="${robotPart.memoryCapacity gt 0}">
                            <tr>
                                <td>Memory size:</td>
                                <td>${robotPart.memoryCapacity}</td>
                                <td colspan="3"></td>
                            </tr>
                        </c:if>
                        <c:if test="${robotPart.cpuCapacity gt 0}">
                            <tr>
                                <td>CPU speed:</td>
                                <td>${robotPart.cpuCapacity}</td>
                                <td>ipc</td>
                                <td colspan="2"></td>
                            </tr>
                        </c:if>
                        <c:if test="${robotPart.forwardCapacity gt 0}">
                            <tr>
                                <td>Engine power:</td>
                                <td>${robotPart.forwardCapacity}/${robotPart.backwardCapacity}/${robotPart.rotateCapacity}</td>
                                <td colspan="2">fwd/bkwd/rot</td>
                                <td></td>
                            </tr>
                        </c:if>
                        <c:if test="${robotPart.powerUsage gt 0}">
                            <tr>
                                <td>Power consumption:</td>
                                <td>${robotPart.powerUsage}</td>
                                <td colspan="3"></td>
                            </tr>
                        </c:if>
                        <c:if test="${robotPart.rechargeTime gt 0}">
                            <tr>
                                <td>Recharge time:</td>
                                <td>${robotPart.rechargeTime}</td>
                                <td>seconds</td>
                                <td colspan="2"></td>
                            </tr>
                        </c:if>
                        <c:if test="${robotPart.weight gt 0}">
                            <tr>
                                <td>Weight:</td>
                                <td>${robotPart.weight}</td>
                                <td colspan="3"></td>
                            </tr>
                        </c:if>
                        <tr>
                            <td colspan="5">Ore cost:</td>
                        </tr>
                        <c:forEach var="orePrice" items="${robotPart.orePrice.orePriceAmountList}">
                            <tr>
                                <td></td>
                                <td colspan="2">${fn:escapeXml(orePrice.ore.oreName)}:</td>
                                <td>${orePrice.amount}</td>
                                <td class="${user.getUserOreAmount(orePrice.ore.id) ge orePrice.amount ? 'sufficientbalance' : 'insufficientbalance'}">(${user.getUserOreAmount(orePrice.ore.id)})</td>
                            </tr>
                        </c:forEach>
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

    </rm:defaultpage>
</rm:robominerheader>
