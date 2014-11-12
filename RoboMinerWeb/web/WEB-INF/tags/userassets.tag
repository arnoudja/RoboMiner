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

<%@ tag description="Show the ore assets" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="oreassetlist" required="true" type="java.util.List<nl.robominer.entity.UserOreAsset>" %>
<%@ attribute name="user" required="true" type="nl.robominer.entity.Users" %>

<div class="userassets">
    <table class="userassets">
        <caption>Assets</caption>
        <tr>
            <th>Ore</th>
            <th>Amount</th>
            <th>Max</th>
        </tr>
        <c:forEach var='oreAsset' items='${oreassetlist}'>
            <tr>
                <td>${fn:escapeXml(oreAsset.ore.oreName)}</td>
                <td>${oreAsset.amount}</td>
                <td>${oreAsset.maxAllowed}</td>
            </tr>
        </c:forEach>
    </table>
    <table class="userassets">
        <caption>${fn:escapeXml(user.username)}</caption>
        <tr>
            <td>Achievements:</td>
            <td>${user.achievementPoints}</td>
        </tr>
        <tr>
            <td>Robots:</td>
            <td>${user.robotList.size()}</td>
        </tr>
        <tr>
            <td>Mining queue:</td>
            <td>${user.miningQueueSize}</td>
        </tr>
    </table>
</div>
