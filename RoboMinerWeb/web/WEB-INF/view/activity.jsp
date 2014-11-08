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
        <script src='js/account.js'></script>
        <title>RoboMiner - Activity</title>
    </head>
    <body>
        <rm:defaultpage currentform="activity" username="${user.username}">
            <table>
                <caption>Latest rallies</caption>
                <tr>
                    <th>Mining Area</th>
                    <th>Robot</th>
                    <th>Player</th>
                    <th></th>
                </tr>
                <c:forEach var="miningQueue" items="${miningQueueList}">
                    <tr>
                        <td>${fn:escapeXml(miningQueue.miningArea.areaName)}</td>
                        <td>${fn:escapeXml(miningQueue.robot.robotName)}</td>
                        <td>${fn:escapeXml(miningQueue.robot.user.username)}</td>
                        <td>
                            <c:if test="${not empty miningQueue.rallyResult}">
                                <a href="<c:url value='activity?rallyResultId=${miningQueue.rallyResult.id}'/>">View</a>
                            </c:if>
                        </td>
                    </tr>
                    <c:forEach var="otherMiningQueue" items="${miningQueue.rallyResult.miningQueueList}">
                        <c:if test="${otherMiningQueue.playerNumber gt 0}">
                            <td></td>
                            <td>${fn:escapeXml(otherMiningQueue.robot.robotName)}</td>
                            <td>${fn:escapeXml(otherMiningQueue.robot.user.username)}</td>
                            <td></td>
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </table>
            <table>
                <caption>Most recent players</caption>
                <tr>
                    <th>Player</th>
                    <th>Last logged in</th>
                </tr>
                <c:forEach var="user" items="${usersList}">
                    <tr>
                        <td>${fn:escapeXml(user.username)}</td>
                        <td><fmt:formatDate value="${user.lastLoginTime}" timeZone="UTC" pattern="yyyy-MM-dd HH:mm:ss z" /></td>
                    </tr>
                </c:forEach>
            </table>
        </rm:defaultpage>
    </body>
</html>
