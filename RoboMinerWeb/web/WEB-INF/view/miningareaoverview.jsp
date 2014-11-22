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
        <title>RoboMiner - Mining area overview</title>
    </head>
    <body>
        <fmt:setLocale value="en_US" />

        <rm:defaultpage currentform="miningAreaOverview" username="${user.username}">

            <table>
                <tr>
                    <th></th>
                    <th>Total</th>
                    <c:forEach var="ore" items="${oreList}">
                        <th>${fn:escapeXml(ore.oreName)}</th>
                    </c:forEach>
                </tr>
                <c:forEach var="miningArea" items="${miningAreaList}">
                    <c:if test="${miningArea.miningAreaLifetimeResultList.size() > 0}">
                        <c:set var="totalPercentage" value="0" />
                        <c:forEach var="ore" items="${oreList}">
                            <c:set var="totalPercentage" value="${totalPercentage + miningArea.getMiningAreaLifetimeResult(ore).percentage}" />
                        </c:forEach>
                        <tr>
                            <td>${fn:escapeXml(miningArea.areaName)}</td>
                            <td><fmt:formatNumber value="${totalPercentage}" minFractionDigits="1" maxFractionDigits="1"/>%</td>
                            <c:forEach var="ore" items="${oreList}">
                                <td><fmt:formatNumber value="${miningArea.getMiningAreaLifetimeResult(ore).percentage}" minFractionDigits="1" maxFractionDigits="1"/>%</td>
                            </c:forEach>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>

        </rm:defaultpage>
    </body>
</html>
