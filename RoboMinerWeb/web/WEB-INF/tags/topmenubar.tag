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

<%@ tag description="The top part of the page containing the menu bar" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="currentform" required="true" %>
<%@ attribute name="username" required="true" %>

<header>
    <nav class="logoff">
        <ul class="menubar">
            <li class="${(currentform == 'help')    ? 'menuitemselected' : 'menuitem'}" onclick="openUrl('<c:url value='help'/>');">Help</li>
            <li class="${(currentform == 'account') ? 'menuitemselected' : 'menuitem'}" onclick="openUrl('<c:url value='account'/>');">${fn:escapeXml(username)}</li>
            <li class="menuitem" onclick="openUrlConfirm('<c:url value='logoff'/>', 'Logoff. Are you sure?');">Logoff</li>
        </ul>
    </nav>
    <nav>
        <ul class="menubar">
            <li class="${(currentform == 'editCode')      ? 'menuitemselected' : 'menuitem'}" onclick="openUrl('<c:url value='editCode'/>');">Edit code</li>
            <li class="${(currentform == 'robot')         ? 'menuitemselected' : 'menuitem'}" onclick="openUrl('<c:url value='robot'/>');">Robots</li>
            <li class="${(currentform == 'miningQueue')   ? 'menuitemselected' : 'menuitem'}" onclick="openUrl('<c:url value='miningQueue'/>');">Mining queue</li>
            <li class="${(currentform == 'miningResults') ? 'menuitemselected' : 'menuitem'}" onclick="openUrl('<c:url value='miningResults'/>');">Mining results</li>
            <li class="${(currentform == 'achievements')  ? 'menuitemselected' : 'menuitem'}" onclick="openUrl('<c:url value='achievements'/>');">Achievements</li>
            <li class="${(currentform == 'shop')          ? 'menuitemselected' : 'menuitem'}" onclick="openUrl('<c:url value='shop'/>');">Shop</li>
            <li class="${(currentform == 'activity')      ? 'menuitemselected' : 'menuitem'}" onclick="openUrl('<c:url value='activity'/>');">Activity</li>
            <li class="${(currentform == 'leaderboard')   ? 'menuitemselected' : 'menuitem'}" onclick="openUrl('<c:url value='leaderboard'/>');">Leaderboard</li>
        </ul>
    </nav>
</header>
