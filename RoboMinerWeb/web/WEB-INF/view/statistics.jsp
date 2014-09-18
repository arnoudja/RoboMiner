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
        <script src='js/statistics.js'></script>
        <title>RoboMiner - Statistics</title>
    </head>
    <body>
        <rm:defaultpage currentform="statistics">

            <rm:userassets oreassetlist='${oreAssetList}' />

            <select class="statistics" onchange="showStatisticsType(this.value);">
                <option value="totalStatistics" selected>Total</option>
                <option value="lastRuns">Last runs</option>
                <option value="today">Today</option>
                <option value="yesterday">Yesterday</option>
                <option value="lastweek">Last 7 days</option>
            </select>

            <div id="totalStatistics">
                <c:forEach var="robot" items="${robotList}">
                    <table class="statistics">
                        <caption>${fn:escapeXml(robot.robotName)}: ${robot.totalMiningRuns} runs</caption>
                        <tr>
                            <th>Ore</th>
                            <th>Amount</th>
                            <th>Tax</th>
                            <th>Reward</th>
                            <th>Average amount per run</th>
                        </tr>
                        <c:set var="totalAmount" value="0"/>
                        <c:set var="totalTax" value="0"/>
                        <c:forEach var="robotLifetimeResult" items="${robot.robotLifetimeResultList}">
                            <c:set var="totalAmount" value="${totalAmount + robotLifetimeResult.amount}"/>
                            <c:set var="totalTax" value="${totalTax + robotLifetimeResult.tax}"/>
                            <tr>
                                <td>${fn:escapeXml(robotLifetimeResult.ore.oreName)}</td>
                                <td>${robotLifetimeResult.amount}</td>
                                <td>${robotLifetimeResult.tax}</td>
                                <td>${robotLifetimeResult.amount - robotLifetimeResult.tax}</td>
                                <td>
                                    <c:if test="${robot.totalMiningRuns gt 0}">
                                        <fmt:formatNumber value="${robotLifetimeResult.amount / robot.totalMiningRuns}" maxFractionDigits="2"/>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td>Total</td>
                            <td>${totalAmount}</td>
                            <td>${totalTax}</td>
                            <td>${totalAmount - totalTax}</td>
                            <td>
                                <c:if test="${robot.totalMiningRuns gt 0}">
                                    <fmt:formatNumber value="${totalAmount / robot.totalMiningRuns}" maxFractionDigits="2"/>
                                </c:if>
                            </td>
                        </tr>
                    </table>
                </c:forEach>
            </div>

            <div id="lastRuns" style="display: none;">
                <c:forEach var="robot" items="${robotList}">
                    <rm:robotstatistics robotName="${robot.robotName}" robotStatistics="${robotLastRunsStatisticsMap.get(robot.id)}" />
                </c:forEach>
            </div>

            <div id="today" style="display: none;">
                <c:forEach var="robot" items="${robotList}">
                    <rm:robotstatistics robotName="${robot.robotName}" robotStatistics="${robotTodayStatisticsMap.get(robot.id)}" />
                </c:forEach>
            </div>

            <div id="yesterday" style="display: none;">
                <c:forEach var="robot" items="${robotList}">
                    <rm:robotstatistics robotName="${robot.robotName}" robotStatistics="${robotYesterdayStatisticsMap.get(robot.id)}" />
                </c:forEach>
            </div>

            <div id="lastweek" style="display: none;">
                <c:forEach var="robot" items="${robotList}">
                    <rm:robotstatistics robotName="${robot.robotName}" robotStatistics="${robotLastWeekStatisticsMap.get(robot.id)}" />
                </c:forEach>
            </div>

        </rm:defaultpage>
    </body>
</html>
