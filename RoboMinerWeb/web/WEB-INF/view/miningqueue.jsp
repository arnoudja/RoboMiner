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
    <rm:defaultpage>

        <script src='js/miningqueue.js'></script>

        <script>
            function robotQueueSize(robotId) {
                switch (robotId) {
                    <c:forEach var="queueSize" items="${miningQueueSizes}">
                        case ${queueSize.key}:
                                    return ${queueSize.value};
                    </c:forEach>
                    default:
                        return 0;
                }
            }
        </script>

        <rm:userassets oreassetlist='${oreAssetList}' />

        <h1>Mining Queue</h1>
        <form id='addqueueform' action="<c:url value='miningQueue'/>" method="post">
            <input type='hidden' id='submitType' name='submitType' value='' />
            <table>
                <tr>
                    <th></th>
                    <th>Robot</th>
                    <th>Area</th>
                    <th>Status</th>
                    <th>ETC</th>
                </tr>
                <c:forEach var='queueItem' items='${miningQueueList}'>
                    <tr>
                        <td class="checkbox">
                            <c:if test="${queueItem.itemStatus.queued}">
                                <input type="checkbox" name="selectedQueueItemId" value="${queueItem.miningQueue.id}" ${queueItem.selected ? 'checked' : ''}/>
                            </c:if>
                        </td>
                        <td>${fn:escapeXml(queueItem.miningQueue.robot.robotName)}</td>
                        <td>${fn:escapeXml(queueItem.miningQueue.miningArea.areaName)}</td>
                        <td>${fn:escapeXml(queueItem.itemStatus.description)}</td>
                        <td id="timeLeft${queueItem.miningQueue.id}"/>
                        <script>countdownTimer(${queueItem.timeLeft} + 1,
                                    function(secondsLeft) {
                                        document.getElementById('timeLeft' + ${queueItem.miningQueue.id}).innerHTML = formatTimeLeft(secondsLeft);
                                    },
                                    function() {
                                        document.getElementById("addqueueform").submit();
                                    });</script>
                    </tr>
                </c:forEach>
                <tr>
                    <td>
                        <input type="button" value="remove" onclick="removeMiningQueueItems();"/>
                    </td>
                </tr>
            </table>
            <h1>Add to Mining Queue</h1>
            <table>
                <tr>
                    <td>
                        <select id="robotId" name="robotId" class="selectiontableselect">
                            <c:forEach var='robot' items='${robotList}'>
                                <option value="${robot.id}" ${robot.id eq robotId ? 'selected="selected"' : ''}>${fn:escapeXml(robot.robotName)}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        <select id='miningAreaId' name="miningAreaId" class="selectiontableselect" onchange='showMiningAreaDetails();'>
                            <c:forEach var='miningArea' items='${miningAreaList}'>
                                <option value="${miningArea.id}" ${miningArea.id eq miningAreaId ? 'selected="selected"' : ''}>${fn:escapeXml(miningArea.areaName)}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        <input type='button' value='add' onclick='addMiningQueueItem();'/>
                    </td>
                </tr>
                <tr>
                    <td/>
                    <td>
                        <c:forEach var='miningArea' items='${miningAreaList}'>
                            <span id='miningAreaDetails${miningArea.id}' style='display: none;'>
                                <table>
                                    <tr>
                                        <td>Tax rate:</td>
                                        <td colspan="2">${miningArea.taxRate}%</td>
                                    </tr>
                                    <c:if test="${fn:length(miningArea.orePrice.orePriceAmountList) gt 0}">
                                        <tr>
                                            <td colspan="3">Core costs:</td>
                                        </tr>
                                        <c:forEach var="orePriceAmount" items="${miningArea.orePrice.orePriceAmountList}">
                                            <tr>
                                                <td/>
                                                <td>${fn:escapeXml(orePriceAmount.ore.oreName)}:</td>
                                                <td>${orePriceAmount.amount}</td>
                                                <td class="${user.getUserOreAmount(orePriceAmount.ore.id) ge orePriceAmount.amount ? 'sufficientbalance' : 'insufficientbalance'}">(${user.getUserOreAmount(orePriceAmount.ore.id)})</td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                    <tr>
                                        <td>Mining time:</td>
                                        <td colspan="2">${miningArea.miningTime} seconds</td>
                                    </tr>
                                    <tr>
                                        <td>Mining cycles:</td>
                                        <td colspan="2">${miningArea.maxMoves}</td>
                                    </tr>
                                    <tr>
                                        <td>Area size:</td>
                                        <td colspan="2">${miningArea.sizeX} x ${miningArea.sizeY}</td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">Available ore:</td>
                                    </tr>
                                    <c:forEach var='miningAreaOreSupply' items="${miningArea.miningAreaOreSupply}">
                                        <tr>
                                            <td/>
                                            <td>${fn:escapeXml(miningAreaOreSupply.ore.oreName)}:</td>
                                            <td>${miningAreaOreSupply.supply} / ${miningAreaOreSupply.radius}</td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </span>
                        </c:forEach>
                    </td>
                </tr>
            </table>
        </form>
        <input id='prevMiningAreaId' type='hidden' value="${miningAreaId}"/>
        <script>showMiningAreaDetails();</script>

    </rm:defaultpage>
</rm:robominerheader>
