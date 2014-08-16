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
<h1>Mining Queue</h1>
<table>
    <c:forEach var='queueItem' items='${miningQueueList}'>
        <tr>
            <td>${queueItem.miningQueue.id}</td>
            <td>${fn:escapeXml(queueItem.miningQueue.robot.robotName)}</td>
            <td>${fn:escapeXml(queueItem.miningQueue.miningArea.areaName)}</td>
            <td>${fn:escapeXml(queueItem.statusDescription)}</td>
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
</table>
<h1>Add to Mining Queue</h1>
<script>
    function showMiningAreaDetails() {
        var prevId = document.getElementById('prevMiningAreaId').value;
        hidePart('miningAreaDetails' + prevId);
        var newId = document.getElementById('miningAreaId').value;
        showPart('miningAreaDetails' + newId);
        document.getElementById('prevMiningAreaId').value = newId;
    }
</script>
<form id='addqueueform' action="<c:url value='miningQueue'/>" method="post">
    <input type='checkbox' id='submitcheck' name='submitType' value='add' hidden='true'/>
    <table>
        <tr>
            <td>
                <select name="robotId" class="selectiontableselect">
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
                <input type='button' value='add' onclick='document.getElementById("submitcheck").checked = true; document.getElementById("addqueueform").submit();'/>
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
