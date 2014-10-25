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

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/robominer.css">
        <script src='js/robominer.js'></script>
        <script src='js/shop.js'></script>
        <title>RoboMiner - Shop</title>
    </head>
    <body>
        <rm:defaultpage currentform="shop" username="${user.username}">

            <rm:userassets oreassetlist="${oreAssetList}" user="${user}" />

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
                    <td>Quality:</td>
                    <td>
                        <select id="tierId" class="tableitem" onchange="showRobotParts();">
                            <c:forEach var="ore" items="${oreList}">
                                <option value="${ore.id}" ${ore.id eq selectedTierId ? 'selected' : ''}>${fn:escapeXml(ore.oreName)} quality</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
            </table>
            <table>
                <caption>Shop items</caption>
                <c:forEach var="robotPartType" items="${robotPartMap}">
                    <c:set var="partnr" value="0" />
                    <c:forEach var="robotPart" items="${robotPartType.value}">
                        <c:set var="partnr" value="${partnr + 1}" />
                        <tbody class="shop" id="robotPartTypeRow${robotPartType.key.id}_${robotPart.tierId}_${partnr}">
                            <tr>
                                <td class="shopFirstRow">Part name:</td>
                                <td class="shopPartName" colspan="3">${fn:escapeXml(robotPart.partName)}</td>
                                <td class="shopFirstRow">
                                    <c:if test="${user.canAffort(robotPart.orePrice) && user.robotList.size() gt user.getTotalRobotPartAmount(robotPart)}">
                                            <button onclick="buyItem(${robotPart.id}, '${fn:escapeXml(robotPart.partName)}');">Buy</button>
                                    </c:if>
                                </td>
                            </tr>
                            <c:if test="${user.getTotalRobotPartAmount(robotPart) gt 0}">
                                <tr>
                                    <td class="important">Owned:</td>
                                    <td>total:</td>
                                    <td colspan="3">${user.getTotalRobotPartAmount(robotPart)}</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>unused:</td>
                                    <td colspan="2">${user.getUnassignedRobotPartAmount(robotPart)}</td>
                                    <td>
                                        <c:if test="${user.getUnassignedRobotPartAmount(robotPart) gt 0}">
                                            <button onclick="sellItem(${robotPart.id}, '${fn:escapeXml(robotPart.partName)}');">Sell</button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:if>
                            <c:if test="${robotPart.oreCapacity gt 0}">
                                <tr>
                                    <td>Ore capacity:</td>
                                    <td colspan="4">${robotPart.oreCapacity} units</td>
                                </tr>
                            </c:if>
                            <c:if test="${robotPart.miningCapacity gt 0}">
                                <tr>
                                    <td>Mining capacity:</td>
                                    <td colspan="4">${robotPart.miningCapacity} o/c</td>
                                </tr>
                            </c:if>
                            <c:if test="${robotPart.batteryCapacity gt 0}">
                                <tr>
                                    <td>Battery capacity:</td>
                                    <td colspan="4">${robotPart.batteryCapacity} pc</td>
                                </tr>
                            </c:if>
                            <c:if test="${robotPart.memoryCapacity gt 0}">
                                <tr>
                                    <td>Memory size:</td>
                                    <td colspan="4">${robotPart.memoryCapacity}</td>
                                </tr>
                            </c:if>
                            <c:if test="${robotPart.cpuCapacity gt 0}">
                                <tr>
                                    <td>CPU speed:</td>
                                    <td colspan="4">${robotPart.cpuCapacity} i/c</td>
                                </tr>
                            </c:if>
                            <c:if test="${robotPart.forwardCapacity gt 0}">
                                <tr>
                                    <td>Engine power:</td>
                                    <td colspan="4">${robotPart.forwardCapacity} forward</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td colspan="4">${robotPart.backwardCapacity} backward</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td colspan="4">${robotPart.rotateCapacity} rotate</td>
                                </tr>
                            </c:if>
                            <c:if test="${robotPart.powerUsage gt 0}">
                                <tr>
                                    <td>Power consumption:</td>
                                    <td colspan="4">${robotPart.powerUsage} p</td>
                                </tr>
                            </c:if>
                            <c:if test="${robotPart.rechargeTime gt 0}">
                                <tr>
                                    <td>Recharge time:</td>
                                    <td colspan="4">
                                        <rm:formatperiod seconds="${robotPart.rechargeTime}"/>
                                    </td>
                                </tr>
                            </c:if>
                            <c:if test="${robotPart.weight gt 0}">
                                <tr>
                                    <td>Weight:</td>
                                    <td colspan="4">${robotPart.weight}</td>
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
                                    <td class="${user.getUserOreAmount(orePrice.ore) ge orePrice.amount ? 'sufficientbalance' : 'insufficientbalance'}">(${user.getUserOreAmount(orePrice.ore)})</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </c:forEach>
                </c:forEach>
            </table>
            <table>
                <caption>Owned items</caption>
                <tr>
                    <th>Item name</th>
                    <th>Quality</th>
                    <th>Amount</th>
                    <th>Unassigned</th>
                    <th></th>
                </tr>
                <c:forEach var="userRobotPartAsset" items="${user.userRobotPartAssetList}">
                    <c:if test="${userRobotPartAsset.totalOwned gt 0}">
                        <tr>
                            <td>${fn:escapeXml(userRobotPartAsset.robotPart.partName)}</td>
                            <td>${fn:escapeXml(userRobotPartAsset.robotPart.tier.oreName)} quality</td>
                            <td>${userRobotPartAsset.totalOwned}</td>
                            <td>${userRobotPartAsset.unassigned}</td>
                            <td>
                                <c:if test="${userRobotPartAsset.unassigned gt 0}">
                                    <button onclick="sellItem(${userRobotPartAsset.robotPart.id}, '${fn:escapeXml(userRobotPartAsset.robotPart.partName)}');">Sell</button>
                                </c:if>
                            </td>
                        </tr>
                    </c:if>
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
    </body>
</html>
