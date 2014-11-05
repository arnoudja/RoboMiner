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
        <script src='js/miningqueue.js'></script>
        <title>RoboMiner - Mining queue</title>
    </head>
    <body>
        <rm:defaultpage currentform="miningQueue" username="${user.username}">

            <button class="helpbutton" onclick="window.open('<c:url value='help_index.html'/>')">help</button>

            <rm:userassets oreassetlist="${oreAssetList}" user="${user}" />

            <form id='miningqueueform' action="<c:url value='miningQueue'/>" method="post">

                <input type='hidden' id='robotId' name='robotId' value='' />
                <input type='hidden' id='miningAreaAddId' name='miningAreaAddId' value='' />
                <input type='hidden' id='submitType' name='submitType' value='' />

                <c:forEach var='robot' items="${user.robotList}">
                    <table class="miningqueue">
                        <caption>${fn:escapeXml(robot.robotName)}</caption>
                        <tr>
                            <th class="miningqueuecheckbox"></th>
                            <th>Area</th>
                            <th class="miningqueuestatus">Status</th>
                            <th class="miningqueuetime">ETC</th>
                        </tr>
                        <c:set var="rownr" value="0"/>
                        <c:forEach var="miningQueueItem" items="${robotMiningQueueMap.get(robot.id)}">
                            <tr>
                                <td class="miningqueuecheckbox">
                                    <c:if test="${rownr gt 0}">
                                        <c:set var="miningQueueId" value="${miningQueueItem.miningQueue.id}" />
                                        <c:set var="ischecked" value="false" />
                                        <c:forEach var="selectedQueueItem" items="${selectedQueueItems}">
                                            <c:if test="${selectedQueueItem eq miningQueueId}">
                                                <c:set var="ischecked" value="true" />
                                            </c:if>
                                        </c:forEach>
                                        <input type="checkbox" name="selectedQueueItemId" value="${miningQueueId}" ${ischecked ? 'checked' : ''}/>
                                    </c:if>
                                </td>
                                <td>${fn:escapeXml(miningQueueItem.miningQueue.miningArea.areaName)}</td>
                                <td class="miningqueuestatus">${fn:escapeXml(miningQueueItem.itemStatus.description)}</td>
                                <td class="miningqueuetime" id="timeLeft${miningQueueItem.miningQueue.id}" >
                                    <script>
                                        <c:choose>
                                            <c:when test="${rownr eq 0}">
                                                countdownTimer(${miningQueueItem.timeLeft} + 1,
                                                    function(secondsLeft) {
                                                        document.getElementById('timeLeft' + ${miningQueueItem.miningQueue.id}).innerHTML = formatTimeLeft(secondsLeft);
                                                    },
                                                    function() {
                                                        document.getElementById("miningqueueform").submit();
                                                    });
                                            </c:when>
                                            <c:otherwise>
                                                countdownTimer(${miningQueueItem.timeLeft} + 1,
                                                    function(secondsLeft) {
                                                        document.getElementById('timeLeft' + ${miningQueueItem.miningQueue.id}).innerHTML = formatTimeLeft(secondsLeft);
                                                    },
                                                    function() {});
                                            </c:otherwise>
                                        </c:choose>
                                    </script>
                                </td>
                            </tr>
                            <c:set var="rownr" value="${rownr + 1}"/>
                        </c:forEach>
                        <tr>
                            <td class="miningqueuebutton">
                                <c:if test="${robotMiningQueueMap.get(robot.id).size() gt 1}">
                                    <input type="button" value="remove" onclick="removeMiningQueueItems(${robot.id});" />
                                </c:if>
                            </td>
                            <td>
                                <select id="miningArea${robot.id}" name="miningArea${robot.id}" class="tableitem" onchange="selectMiningAreaDetails(this.value);">
                                    <c:forEach var='miningArea' items='${user.miningAreaList}'>
                                        <option value="${miningArea.id}" ${miningArea.id eq robotMiningAreaIdMap.get(robot.id) ? 'selected' : ''} >${fn:escapeXml(miningArea.areaName)}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td class="miningqueuebutton">
                                <c:if test="${user.miningQueueSize gt robotMiningQueueMap.get(robot.id).size()}">
                                    <input type='button' value='add' onclick="addMiningQueueItem(${robot.id}, 'miningArea${robot.id}');"/>
                                </c:if>
                            </td>
                            <td class="miningqueuebutton">
                                <c:if test="${user.miningQueueSize gt robotMiningQueueMap.get(robot.id).size()}">
                                    <input type='button' value='fill' onclick="fillMiningQueue(${robot.id}, 'miningArea${robot.id}');"/>
                                </c:if>
                            </td>
                        </tr>
                    </table>
                </c:forEach>

                <div class="miningqueue">
                    <c:if test="${not empty errorMessage}">
                        <p class="error">${errorMessage}</p>
                    </c:if>

                    <h1>Mining area info</h1>
                    <input type="button" value="Overview" onclick="openUrl('<c:url value='miningAreaOverview'/>');"/>

                    <table>
                        <tr>
                            <th>Mining area:</th>
                            <th colspan="3">
                                <select id='infoMiningAreaId' name="infoMiningAreaId" class="tableitem" onchange='showMiningAreaDetails();'>
                                    <c:forEach var='miningArea' items='${user.miningAreaList}'>
                                        <option value="${miningArea.id}" ${miningArea.id eq infoMiningAreaId ? 'selected="selected"' : ''}>${fn:escapeXml(miningArea.areaName)}</option>
                                    </c:forEach>
                                </select>
                            </th>
                        </tr>
                        <c:forEach var='miningArea' items='${user.miningAreaList}'>
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
                                            <td class="${user.getUserOreAmount(orePriceAmount.ore) ge orePriceAmount.amount ? 'sufficientbalance' : 'insufficientbalance'}">(${user.getUserOreAmount(orePriceAmount.ore)})</td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                                <tr>
                                    <td>Mining time:</td>
                                    <td colspan="3">
                                        <rm:formatperiod seconds="${miningArea.miningTime}"/>
                                    </td>
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
                </div>
            </form>

            <input id='prevInfoMiningAreaId' type='hidden' value="${infoMiningAreaId}"/>

        </rm:defaultpage>

        <script>showMiningAreaDetails();</script>

    </body>
</html>
