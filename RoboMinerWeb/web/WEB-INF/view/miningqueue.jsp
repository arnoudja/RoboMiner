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

<rm:robominerheader>

    <script src='js/miningqueue.js'></script>

    <rm:defaultpage currentform="miningQueue">

        <rm:userassets oreassetlist='${oreAssetList}' />

        <form id='miningqueueform' action="<c:url value='miningQueue'/>" method="post">

            <input type='hidden' id='robotId' name='robotId' value='' />
            <input type='hidden' id='miningAreaAddId' name='miningAreaAddId' value='' />
            <input type='hidden' id='submitType' name='submitType' value='' />

            <c:set var="canremove" value="false"/>
            
            <table>
                <caption>Mining queues</caption>
                <tr>
                    <c:forEach var='robot' items="${robotList}">
                        <th>${fn:escapeXml(robot.robotName)}</th>
                        <th>Area</th>
                        <th>Status</th>
                        <th class="miningqueuetime">ETC</th>
                    </c:forEach>
                </tr>
                <c:if test="${largestQueueSize gt 0}">
                    <c:forEach var='rownr' begin="0" end="${largestQueueSize - 1}">
                        <tr>
                            <c:forEach var='robot' items="${robotList}">
                                <c:choose>
                                    <c:when test="${robotMiningQueueMap.get(robot.id).size() gt rownr}">
                                        <td class="miningqueuecheckbox">
                                            <c:if test="${rownr gt 0}">
                                                <c:set var="miningQueueId" value="${robotMiningQueueMap.get(robot.id).get(rownr).miningQueue.id}" />
                                                <c:set var="ischecked" value="false" />
                                                <c:forEach var="selectedQueueItem" items="${selectedQueueItems}">
                                                    <c:if test="${selectedQueueItem eq miningQueueId}">
                                                        <c:set var="ischecked" value="true" />
                                                    </c:if>
                                                </c:forEach>
                                                <input type="checkbox" name="selectedQueueItemId" value="${miningQueueId}" ${ischecked ? 'checked' : ''}/>
                                                <c:set var="canremove" value="true"/>
                                            </c:if>
                                        </td>
                                        <td>${fn:escapeXml(robotMiningQueueMap.get(robot.id).get(rownr).miningQueue.miningArea.areaName)}</td>
                                        <td>${fn:escapeXml(robotMiningQueueMap.get(robot.id).get(rownr).itemStatus.description)}</td>
                                        <td class="miningqueuetime" id="timeLeft${robotMiningQueueMap.get(robot.id).get(rownr).miningQueue.id}"/>
                                        <script>
                                            countdownTimer(${robotMiningQueueMap.get(robot.id).get(rownr).timeLeft} + 1,
                                                function(secondsLeft) {
                                                    document.getElementById('timeLeft' + ${robotMiningQueueMap.get(robot.id).get(rownr).miningQueue.id}).innerHTML = formatTimeLeft(secondsLeft);
                                                },
                                                function() {
                                                    document.getElementById("miningqueueform").submit();
                                                });
                                        </script>
                                    </c:when>
                                    <c:otherwise>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                </c:if>
                <tr>
                    <c:forEach var='robot' items="${robotList}">
                        <c:choose>
                            <c:when test="${maxQueueSize gt robotMiningQueueMap.get(robot.id).size()}">
                                <td></td>
                                <td>
                                    <select id="miningArea${robot.id}" name="miningArea${robot.id}" class="tableitem" onchange="selectMiningAreaDetails(this.value);">
                                        <c:forEach var='miningArea' items='${miningAreaList}'>
                                            <option value="${miningArea.id}" ${miningArea.id eq robotMiningAreaId.get(robot.id) ? 'selected' : ''} >${fn:escapeXml(miningArea.areaName)}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td>
                                    <input type='button' value='add' onclick="addMiningQueueItem(${robot.id}, 'miningArea${robot.id}');"/>
                                </td>
                                <td></td>
                            </c:when>
                            <c:otherwise>
                                <td colspan="4"></td>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </tr>
            </table>

            <c:if test="${not empty errorMessage}">
                <p class="error">${errorMessage}</p>
            </c:if>

            <c:if test="${canremove}">
                <br>
                <input type="button" value="Remove selected" onclick="removeMiningQueueItems();"/>
            </c:if>

            <h1>Mining area info</h1>
            <input type="button" value="Overview" onclick="openUrl('<c:url value='miningAreaOverview'/>');"/>

            <table>
                <tr>
                    <th>Mining area:</th>
                    <th colspan="3">
                        <select id='miningAreaId' name="miningAreaId" class="tableitem" onchange='showMiningAreaDetails();'>
                            <c:forEach var='miningArea' items='${miningAreaList}'>
                                <option value="${miningArea.id}" ${miningArea.id eq miningAreaId ? 'selected="selected"' : ''}>${fn:escapeXml(miningArea.areaName)}</option>
                            </c:forEach>
                        </select>
                    </th>
                </tr>
                <c:forEach var='miningArea' items='${miningAreaList}'>
                    <tbody id='miningAreaDetails${miningArea.id}' style="display: none;">
                        <tr>
                            <td>Tax rate:</td>
                            <td colspan="3">${miningArea.taxRate}%</td>
                        </tr>
                        <c:if test="${fn:length(miningArea.orePrice.orePriceAmountList) gt 0}">
                            <tr>
                                <td colspan="4">Core costs:</td>
                            </tr>
                            <c:forEach var="orePriceAmount" items="${miningArea.orePrice.orePriceAmountList}">
                                <tr>
                                    <td></td>
                                    <td>${fn:escapeXml(orePriceAmount.ore.oreName)}:</td>
                                    <td>${orePriceAmount.amount}</td>
                                    <td class="${user.getUserOreAmount(orePriceAmount.ore.id) ge orePriceAmount.amount ? 'sufficientbalance' : 'insufficientbalance'}">(${user.getUserOreAmount(orePriceAmount.ore.id)})</td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        <tr>
                            <td>Mining time:</td>
                            <td colspan="3">${miningArea.miningTime} seconds</td>
                        </tr>
                        <tr>
                            <td>Mining cycles:</td>
                            <td colspan="3">${miningArea.maxMoves}</td>
                        </tr>
                        <tr>
                            <td>Area size:</td>
                            <td colspan="3">${miningArea.sizeX} x ${miningArea.sizeY}</td>
                        </tr>
                        <tr>
                            <td colspan="4">Available ore:</td>
                        </tr>
                        <c:forEach var='miningAreaOreSupply' items="${miningArea.miningAreaOreSupply}">
                            <tr>
                                <td></td>
                                <td>${fn:escapeXml(miningAreaOreSupply.ore.oreName)}:</td>
                                <td colspan="2">${miningAreaOreSupply.supply} / ${miningAreaOreSupply.radius}</td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="4">Historic yield:</td>
                        </tr>
                        <c:set var="totalPercentage" value="0.0"/>
                        <c:forEach var="miningAreaLifetimeResult" items="${miningArea.miningAreaLifetimeResultList}">
                            <c:set var="totalPercentage" value="${totalPercentage + miningAreaLifetimeResult.percentage}"/>
                            <tr>
                                <td></td>
                                <td>${fn:escapeXml(miningAreaLifetimeResult.ore.oreName)}:</td>
                                <td colspan="2">
                                    <fmt:formatNumber value="${miningAreaLifetimeResult.percentage}" minFractionDigits="2" maxFractionDigits="2"/>%
                                </td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td></td>
                            <td>Total:</td>
                            <td colspan="2">
                                <fmt:formatNumber value="${totalPercentage}" minFractionDigits="2" maxFractionDigits="2"/>%
                            </td>
                        </tr>
                    </tbody>
                </c:forEach>
            </table>
        </form>

        <input id='prevMiningAreaId' type='hidden' value="${miningAreaId}"/>

    </rm:defaultpage>

    <script>showMiningAreaDetails();</script>

</rm:robominerheader>
