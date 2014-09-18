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
        <title>RoboMiner - Leaderboard</title>
    </head>
    <body>
        <rm:defaultpage currentform="leaderboard">

            <table>
                <caption>Top robots</caption>
                <tr>
                    <th>Robot</th>
                    <th>Owner</th>
                    <th>Average ore per run</th>
                </tr>
                <c:forEach var="topRobot" items="${topRobotsList}">
                    <tr>
                        <td>${fn:escapeXml(topRobot.robotName)}</td>
                        <td>${fn:escapeXml(topRobot.username)}</td>
                        <td>
                            <fmt:formatNumber value="${topRobot.orePerRun}" minFractionDigits="3" maxFractionDigits="3"/>
                        </td>
                    </tr>
                </c:forEach>
            </table>

        </rm:defaultpage>
    </body>
</html>
