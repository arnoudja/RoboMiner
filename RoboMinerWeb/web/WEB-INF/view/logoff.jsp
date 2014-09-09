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
<%@ taglib prefix="rm" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<rm:robominerheader>
    <div class="main">
        <header>
            <nav>
                <ul class="menubar">
                </ul>
            </nav>
        </header>
        <div class="interface">
            <h1>Logoff</h1>
            <p>Logged off successful</p>
            <p><a href="<c:url value='login'/>">Login</a> again</p>
        </div>
        <rm:pagefooter/>
    </div>
</rm:robominerheader>
