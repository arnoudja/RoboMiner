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

<%@ tag description="Display the statistics for a robot" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ attribute name="robotStatistics" type="nl.robominer.businessentity.RobotStatistics" required="true" %>
<%@ attribute name="robotName" required="true" %>

<table class="statistics">
    <caption>${fn:escapeXml(robotName)}: ${robotStatistics.runs} runs</caption>
    <tr>
        <th>Ore</th>
        <th>Amount</th>
        <th>Tax</th>
        <th>Reward</th>
        <th>Average amount per run</th>
    </tr>
    <c:set var="totalAmount" value="0"/>
    <c:set var="totalTax" value="0"/>
    <c:forEach var="oreAmountEntry" items="${robotStatistics.oreAmountMap.entrySet()}">
        <c:set var="totalAmount" value="${totalAmount + oreAmountEntry.value.amount}"/>
        <c:set var="totalTax" value="${totalTax + oreAmountEntry.value.tax}"/>
        <tr>
            <td>${fn:escapeXml(oreAmountEntry.key.oreName)}</td>
            <td>${oreAmountEntry.value.amount}</td>
            <td>${oreAmountEntry.value.tax}</td>
            <td>${oreAmountEntry.value.amount - oreAmountEntry.value.tax}</td>
            <td>
                <c:if test="${robotStatistics.runs gt 0}">
                    <fmt:formatNumber value="${oreAmountEntry.value.amount / robotStatistics.runs}" maxFractionDigits="2"/>
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
            <c:if test="${robotStatistics.runs gt 0}">
                <fmt:formatNumber value="${totalAmount / robotStatistics.runs}" maxFractionDigits="2"/>
            </c:if>
        </td>
    </tr>
</table>
