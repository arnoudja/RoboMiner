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
<h1>Ore assets</h1>
<table>
    <tr>
        <th>Ore</th>
        <th>Amount</th>
    </tr>
    <c:forEach var='oreAsset' items='${oreAssetList}'>
        <tr>
            <td>${fn:escapeXml(oreAsset.ore.oreName)}</td>
            <td>${oreAsset.amount}</td>
        </tr>
    </c:forEach>
</table>
<h1>Mining Results</h1>
<table>
    <tr>
        <th>id</th>
        <th>Robot</th>
        <th>Area</th>
        <th>Ore</th>
        <th>Amount</th>
        <th>Tax</th>
        <th>Result</th>
    </tr>
    <c:forEach var='miningResult' items='${miningResultsList}'>
        <tr>
            <td>${miningResult.id}</td>
            <td>${fn:escapeXml(miningResult.robot.robotName)}</td>
            <td>${fn:escapeXml(miningResult.miningArea.areaName)}</td>
            <td colspan="4" />
            <td><a href="<c:url value='miningResults?rallyResultId=${miningResult.rallyResult.id}'/>">View</a></td>
        </tr>
        <c:forEach var='miningOreResult' items='${miningResult.miningOreResults}'>
            <tr>
                <td colspan="3" />
                <td>${fn:escapeXml(miningOreResult.ore.oreName)}</td>
                <td>${miningOreResult.amount}</td>
                <td>${miningOreResult.tax}</td>
                <td>${miningOreResult.reward}</td>
            </tr>
        </c:forEach>
    </c:forEach>
</table>