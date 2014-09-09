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

        <table class="miningresults">
            <caption>Mining results</caption>
            <tr class="miningresultsheader">
                <th class="miningresults" colspan="4"></th>
                <th class="miningresults">Amount</th>
                <th class="miningresults">Tax</th>
                <th class="miningresults">Result</th>
                <td class="miningresults"></td>
            </tr>
            <c:forEach var='miningResult' items='${miningResultsList}'>
                <tbody class="miningresults">
                    <tr>
                        <td class="miningresults"><button onclick="swapShowDetails('resultDetails_${miningResult.id}', this);">+</button></td>
                        <td class="miningresults">${fn:escapeXml(miningResult.robot.robotName)}</td>
                        <td class="miningresults">${fn:escapeXml(miningResult.miningArea.areaName)}</td>
                        <td class="miningresults">
                            <c:if test="${miningResult.miningOreResults.size() eq 1}">
                                ${fn:escapeXml(miningResult.miningOreResults[0].ore.oreName)}
                            </c:if>
                        </td>
                        <td class="miningresults">${miningResult.totalOreMined}</td>
                        <td class="miningresults">${miningResult.totalTax}</td>
                        <td class="miningresults">${miningResult.totalReward}</td>
                        <td class="miningresults"><a href="<c:url value='miningResults?rallyResultId=${miningResult.rallyResult.id}'/>">View</a></td>
                    </tr>
                    <c:if test="${miningResult.miningOreResults.size() gt 1}">
                        <c:forEach var='miningOreResult' items='${miningResult.miningOreResults}'>
                            <tr class="miningresultsdetails" name="resultDetails_${miningResult.id}">
                                <td class="miningresults" colspan="3"></td>
                                <td class="miningresults">${fn:escapeXml(miningOreResult.ore.oreName)}</td>
                                <td class="miningresults">${miningOreResult.amount}</td>
                                <td class="miningresults">${miningOreResult.tax}</td>
                                <td class="miningresults">${miningOreResult.reward}</td>
                                <td class="miningresults"></td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <tr class="miningresultsdetails" name="resultDetails_${miningResult.id}">
                        <td class="miningresults"></td>
                        <td class="miningresults">Queued:</td>
                        <td class="miningresults"><fmt:formatDate value="${miningResult.creationTime}" timeZone="UTC" pattern="yyyy-MM-dd HH:mm:ss z" /></td>
                        <td class="miningresults" colspan="5"></td>
                    </tr>
                    <tr class="miningresultsdetails" name="resultDetails_${miningResult.id}">
                        <td class="miningresults"></td>
                        <td class="miningresults">Mining end:</td>
                        <td class="miningresults"><fmt:formatDate value="${miningResult.miningEndTime}" timeZone="UTC" pattern="yyyy-MM-dd HH:mm:ss z" /></td>
                        <td class="miningresults" colspan="5"></td>
                    </tr>
                </tbody>
            </c:forEach>
        </table>

    </rm:defaultpage>
</rm:robominerheader>
