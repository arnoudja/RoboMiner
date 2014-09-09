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

<%@ tag description="The default page layout, containing the menu bar at the top and the footer bar" pageEncoding="UTF-8"%>
<%@ taglib prefix="rm" tagdir="/WEB-INF/tags" %>
<%@ attribute name="currentform" required="true" %>

<div class="main">
    <rm:topmenubar currentform="${currentform}"/>
    <div class="interface">
        <jsp:doBody/>
    </div>
    <rm:pagefooter/>
</div>