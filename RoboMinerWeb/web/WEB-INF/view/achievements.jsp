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
<%@ taglib prefix="rm" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/robominer.css">
        <script src='js/robominer.js'></script>
        <script src='js/achievements.js'></script>
        <title>RoboMiner - Achievements</title>
    </head>
    <body>
        <rm:defaultpage currentform="achievements" username="${user.username}">

            <rm:userassets oreassetlist="${oreAssetList}" user="${user}" />

            <form id="claimAchievementForm" action="<c:url value='achievements'/>" method="post">
                <input type="hidden" id="achievementId" name="achievementId" value="" />
            </form>

            <table>
                <caption>Unclaimed</caption>
                <c:forEach var="userAchievement" items="${userAchievementList}">
                    <c:set var="achievement" value="${userAchievement.achievement}" />
                    <c:set var="achievementMiningTotalRequirementList" value="${achievement.achievementMiningTotalRequirementList}" />
                    <c:set var="claimable" value="true" />
                    <tbody class="achievements">
                        <tr>
                            <th colspan="3">${fn:escapeXml(achievement.title)}</th>
                        </tr>
                        <tr>
                            <td colspan="3">${fn:escapeXml(achievement.description)}</td>
                        </tr>
                        <tr>
                            <td colspan="3" class="important">Rewards</td>
                        </tr>
                        <tr>
                            <td>Achievement points:</td>
                            <td colspan="2">${achievement.achievementPoints}</td>
                        </tr>
                        <c:if test="${achievement.miningQueueReward gt 0}">
                            <tr>
                                <td>Queue increase:</td>
                                <td colspan="2">${achievement.miningQueueReward}</td>
                            </tr>
                        </c:if>
                        <c:if test="${achievement.robotReward gt user.robotList.size()}">
                            <tr>
                                <td colspan="3" class="important">New robot</td>
                            </tr>
                        </c:if>
                        <c:if test="${not empty achievement.miningArea}">
                            <tr>
                                <td>Mining area:</td>
                                <td colspan="2">${achievement.miningArea.areaName}</td>
                            </tr>
                        </c:if>
                        <tr>
                            <td colspan="3" class="important">Requirements</td>
                        </tr>
                        <c:forEach var="achievementMiningTotalRequirement" items="${achievementMiningTotalRequirementList}">
                            <c:set var="totalMined" value="${totalOreMined.get(achievementMiningTotalRequirement.ore.id)}" />
                            <c:if test="${empty totalMined}">
                                <c:set var="totalMined" value="0" />
                            </c:if>
                            <c:if test="${totalMined lt achievementMiningTotalRequirement.amount}">
                                <c:set var="claimable" value="false" />
                            </c:if>
                            <tr>
                                <td>${fn:escapeXml(achievementMiningTotalRequirement.ore.oreName)}</td>
                                <td>${achievementMiningTotalRequirement.amount}</td>
                                <td class="${totalMined ge achievementMiningTotalRequirement.amount ? 'sufficientbalance' : 'insufficientbalance'}">
                                    (${totalMined})
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${claimable}">
                            <tr>
                                <td colspan="3">
                                    <button onclick="claimAchievement(${achievement.id});">Claim</button>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </c:forEach>
            </table>

        </rm:defaultpage>
    </body>
</html>
