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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="rm" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<rm:robominerheader>
    <rm:defaultpage currentform="miningResults">

        <script src='js/miningresults.js'></script>

        <rm:userassets oreassetlist='${oreAssetList}' />

        <c:forEach var="robot" items="${robotList}">
            <table>
                <caption>${fn:escapeXml(robot.robotName)}</caption>
                <tr class="miningresultsheader">
                    <th colspan="3"></th>
                    <th>Amount</th>
                    <th>Tax</th>
                    <th>Result</th>
                    <th></th>
                </tr>
                <c:forEach var="miningResult" items="${miningResultListMap.get(robot.id)}">
                    <tbody class="miningresults">
                        <tr>
                            <td><button onclick="swapShowDetails('resultDetails_${miningResult.id}', this);">+</button></td>
                            <td>${fn:escapeXml(miningResult.miningArea.areaName)}</td>
                            <td>
                                <c:if test="${miningResult.miningOreResults.size() eq 1}">
                                    ${fn:escapeXml(miningResult.miningOreResults[0].ore.oreName)}
                                </c:if>
                            </td>
                            <td>${miningResult.totalOreMined}</td>
                            <td>${miningResult.totalTax}</td>
                            <td>${miningResult.totalReward}</td>
                            <td><a href="<c:url value='miningResults?rallyResultId=${miningResult.rallyResult.id}'/>">View</a></td>
                        </tr>
                        <c:if test="${miningResult.miningOreResults.size() gt 1}">
                            <c:forEach var='miningOreResult' items='${miningResult.miningOreResults}'>
                                <tr class="miningresultsdetails" name="resultDetails_${miningResult.id}">
                                    <td colspan="2"></td>
                                    <td>${fn:escapeXml(miningOreResult.ore.oreName)}</td>
                                    <td>${miningOreResult.amount}</td>
                                    <td>${miningOreResult.tax}</td>
                                    <td>${miningOreResult.reward}</td>
                                    <td></td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        <tr class="miningresultsdetails" name="resultDetails_${miningResult.id}">
                            <td></td>
                            <td>Queued:</td>
                            <td colspan="5"><fmt:formatDate value="${miningResult.creationTime}" timeZone="UTC" pattern="yyyy-MM-dd HH:mm:ss z" /></td>
                        </tr>
                        <tr class="miningresultsdetails" name="resultDetails_${miningResult.id}">
                            <td></td>
                            <td>Mining end:</td>
                            <td colspan="5"><fmt:formatDate value="${miningResult.miningEndTime}" timeZone="UTC" pattern="yyyy-MM-dd HH:mm:ss z" /></td>
                        </tr>
                    </tbody>
                </c:forEach>
            </table>
        </c:forEach>
    </rm:defaultpage>
</rm:robominerheader>
