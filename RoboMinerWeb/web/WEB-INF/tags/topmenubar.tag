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

<%@ tag description="The top part of the page containing the menu bar" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header>
    <nav style="float: right; margin-right: 10px;">
        <ul class="menubar">
            <li class="menuitem" onclick="openUrl('<c:url value='logoff'/>');"><p class="menuitemtext">Logoff</p></li>
        </ul>
    </nav>
    <nav>
        <ul class="menubar">
            <li class="menuitem" onclick="openUrl('<c:url value='editCode'/>');"><p class="menuitemtext">Edit code</p></li>
            <li class="menuitem" onclick="openUrl('<c:url value='robot'/>');"><p class="menuitemtext">Robots</p></li>
            <li class="menuitem" onclick="openUrl('<c:url value='miningQueue'/>');"><p class="menuitemtext">Mining queue</p></li>
            <li class="menuitem" onclick="openUrl('<c:url value='miningResults'/>');"><p class="menuitemtext">Mining results</p></li>
            <li class="menuitem" onclick="openUrl('<c:url value='shop'/>');"><p class="menuitemtext">Shop</p></li>
        </ul>
    </nav>
</header>
