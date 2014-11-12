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
        <script src='js/achievements.js'></script>
        <title>RoboMiner - Achievements</title>
    </head>
    <body>
        <fmt:setLocale value="en_US" />

        <rm:defaultpage currentform="achievements" username="${user.username}">

            <rm:userassets oreassetlist="${oreAssetList}" user="${user}" />

            <form id="claimAchievementForm" action="<c:url value='achievements'/>" method="post">
                <input type="hidden" id="achievementId" name="achievementId" value="" />
            </form>

            <c:forEach var="userAchievement" items="${user.userAchievementList}">
                <c:set var="achievement" value="${userAchievement.achievement}" />
                <c:if test="${achievement.numberOfSteps gt userAchievement.stepsClaimed}">
                    <table>
                        <tr>
                            <th colspan="3">${fn:escapeXml(achievement.title)}</th>
                        </tr>
                        <tr>
                            <td colspan="3">${fn:escapeXml(achievement.description)}</td>
                        </tr>
                        <tr>
                            <td colspan="2">Completed</td>
                            <td>${userAchievement.stepsClaimed} / ${achievement.numberOfSteps}</td>
                        </tr>
                        <tr>
                            <td colspan="2">Achievement points</td>
                            <td>${userAchievement.achievementPointsEarned} / ${achievement.totalAchievementPoints}</td>
                        </tr>
                        <c:if test="${achievement.numberOfSteps gt userAchievement.stepsClaimed}">
                            <c:set var="achievementStep" value="${achievement.getAchievementStep(userAchievement.stepsClaimed + 1)}" />
                            <c:set var="achievementStepMiningTotalRequirementList" value="${achievementStep.achievementStepMiningTotalRequirementList}" />
                            <c:set var="achievementStepMiningScoreRequirementList" value="${achievementStep.achievementStepMiningScoreRequirementList}" />
                            <tr>
                                <td colspan="3" class="important">Next reward</td>
                            </tr>
                            <tr>
                                <td colspan="2">Achievement points</td>
                                <td>${achievementStep.achievementPoints}</td>
                            </tr>
                            <c:if test="${achievementStep.miningQueueReward gt 0}">
                                <tr>
                                    <td colspan="2">Queue increase:</td>
                                    <td>${achievementStep.miningQueueReward}</td>
                                </tr>
                            </c:if>
                            <c:if test="${not empty achievementStep.ore}">
                                <tr>
                                    <td colspan="2">${fn:escapeXml(achievementStep.ore.oreName)} ore maximum:</td>
                                    <td>${achievementStep.maxOreReward}</td>
                                </tr>
                            </c:if>
                            <c:if test="${achievementStep.robotReward gt user.robotList.size()}">
                                <tr>
                                    <td colspan="3">New robot!</td>
                                </tr>
                            </c:if>
                            <c:if test="${not empty achievementStep.miningArea}">
                                <tr>
                                    <td colspan="2">Mining area:</td>
                                    <td>${achievementStep.miningArea.areaName}</td>
                                </tr>
                            </c:if>
                            <tr>
                                <td colspan="3" class="important">Requirements</td>
                            </tr>
                            <c:forEach var="achievementStepMiningTotalRequirement" items="${achievementStepMiningTotalRequirementList}">
                                <c:set var="totalMined" value="${user.getTotalOreMined(achievementStepMiningTotalRequirement.ore.id)}" />
                                <tr>
                                    <td>${fn:escapeXml(achievementStepMiningTotalRequirement.ore.oreName)} mined</td>
                                    <td>${achievementStepMiningTotalRequirement.amount}</td>
                                    <td class="${totalMined ge achievementStepMiningTotalRequirement.amount ? 'sufficientbalance' : 'insufficientbalance'}">
                                        (${totalMined})
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:forEach var="achievementStepMiningScoreRequirement" items="${achievementStepMiningScoreRequirementList}">
                                <c:set var="currentScore" value="${user.getMiningAreaScore(achievementStepMiningScoreRequirement.miningArea.id)}" />
                                <tr>
                                    <td>Average ${fn:escapeXml(achievementStepMiningScoreRequirement.miningArea.areaName)} score</td>
                                    <td>
                                        <fmt:formatNumber value="${achievementStepMiningScoreRequirement.minimumScore}" minFractionDigits="1" maxFractionDigits="1"/>
                                    </td>
                                    <td class="${currentScore ge achievementStepMiningScoreRequirement.minimumScore ? 'sufficientbalance' : 'insufficientbalance'}">
                                        (<fmt:formatNumber value="${currentScore}" minFractionDigits="1" maxFractionDigits="1"/>)
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${userAchievement.claimable}">
                                <tr>
                                    <td colspan="3">
                                        <button onclick="claimAchievement(${achievement.id});">Claim</button>
                                    </td>
                                </tr>
                            </c:if>
                        </c:if>
                    </table>
                </c:if>
            </c:forEach>

        </rm:defaultpage>
    </body>
</html>
