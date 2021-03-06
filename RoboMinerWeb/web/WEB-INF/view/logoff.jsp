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

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/robominer.css">
        <script src='js/robominer.js'></script>
        <title>RoboMiner - Logged off</title>
    </head>
    <body>
        <div class="main">
            <header>
                <nav class="logoff">
                    <ul class="menubar">
                        <li class="menuitemselected">Logoff</li>
                    </ul>
                </nav>
                <nav>
                    <ul class="menubar">
                        <li class="menuitem" onclick="openUrl('<c:url value='login'/>');">Login</li>
                    </ul>
                </nav>
            </header>
            <div class="interface">
                <p>Logged off successful</p>
                <p><a href="<c:url value='login'/>">Login</a> again</p>
            </div>
            <rm:pagefooter/>
        </div>
    </body>
</html>
