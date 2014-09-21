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
        <script src='js/animation.js'></script>
        <title>RoboMiner - View rally</title>
    </head>
    <body>
        <rm:defaultpage currentform="viewRally" username="${user.username}">

            <div style="position: relative; min-height: 650px; width: 1100px; margin: 0 auto; margin-top: 10px;">
                <div style="position: absolute; left: 0; top: 0;">
                    <canvas id="rallyCanvas" width="600" height="600"></canvas>
                </div>
                <div style="position: absolute; left: 620px; top: 0; width: 300px; height: 600px;">
                    <div style="position: absolute; left: 0; top: 0; width: 150px; height: 300px;">
                        <p>${fn:escapeXml(player0)}<br>${fn:escapeXml(robot0)}</p>
                        <canvas id="oreCanvas0" width="50" height="200"></canvas>
                    </div>
                    <div style="position: absolute; left: 0; top: 300px; width: 150px; height: 300px;">
                        <p>${fn:escapeXml(player1)}<br>${fn:escapeXml(robot1)}</p>
                        <canvas id="oreCanvas1" width="50" height="200"></canvas>
                    </div>
                    <div style="position: absolute; left: 150px; top: 0; width: 150px; height: 300px;">
                        <p>${fn:escapeXml(player2)}<br>${fn:escapeXml(robot2)}</p>
                        <canvas id="oreCanvas2" width="50" height="200"></canvas>
                    </div>
                    <div style="position: absolute; left: 150px; top: 300px; width: 150px; height: 300px;">
                        <p>${fn:escapeXml(player3)}<br>${fn:escapeXml(robot3)}</p>
                        <canvas id="oreCanvas3" width="50" height="200"></canvas>
                    </div>
                </div>
                <div style="position: absolute; left: 950px; top: 0; width: 150px; height: 300px;">
                    <div id="oreLegendA" style="display: none;">
                        <span style="position: absolute; left: 0; top: 0;">
                            <canvas id="oreLegendACanvas" width="25" height="25"></canvas>
                        </span>
                        <span id="oreLegendAName" style="position: absolute; left: 30px; top: 5px;">OreA</span>
                    </div>
                    <div id="oreLegendB" style="display: none;">
                        <span style="position: absolute; left: 0; top: 30px;">
                            <canvas id="oreLegendBCanvas" width="25" height="25"></canvas>
                        </span>
                        <span id="oreLegendBName" style="position: absolute; left: 30px; top: 35px;">OreB</span>
                    </div>
                    <div id="oreLegendC" style="display: none;">
                        <span style="position: absolute; left: 0; top: 60px;">
                            <canvas id="oreLegendCCanvas" width="25" height="25"></canvas>
                        </span>
                        <span id="oreLegendCName" style="position: absolute; left: 30px; top: 65px;">OreC</span>
                    </div>
                </div>
                <div style="position: absolute; left: 0; top: 610px;">
                    <canvas id="progressCanvas" width="600" height="50"></canvas>
                </div>
                <div style="position: absolute; left: 610px; top: 610px;">
                    <input type="text" id="cyclenr" size="5" readonly="true">
                </div>
            </div>
            <script>
                function getOreName(oreId) {

                    switch (oreId) {
                <c:forEach var="ore" items="${oreList}">
                        case ${ore.id}:
                            return '${fn:escapeXml(ore.oreName)}';
                </c:forEach>
                        default:
                            return '';
                    }
                }

                window.requestAnimFrame = (function(callback) {
                    return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame ||
                            function(callback) {
                                window.setTimeout(callback, 1000 / 60);
                            };
                    })();
                ${rallyData}

                var myRallyCanvas = document.getElementById('rallyCanvas');
                var myRallyContext = rallyCanvas.getContext('2d');

                var myOreCanvas = [ document.getElementById('oreCanvas0'), document.getElementById('oreCanvas1'), document.getElementById('oreCanvas2'), document.getElementById('oreCanvas3') ];
                var myOreContext = [ myOreCanvas[0].getContext('2d'), myOreCanvas[1].getContext('2d'), myOreCanvas[2].getContext('2d'), myOreCanvas[3].getContext('2d') ];

                var myProgressCanvas = document.getElementById('progressCanvas');
                var myProgressContext = progressCanvas.getContext('2d');
                var myCycleText = document.getElementById('cyclenr');

                if (typeof myOreTypes.A !== 'undefined') {
                    var canvas = document.getElementById('oreLegendACanvas');
                    var context = canvas.getContext('2d');
                    context.beginPath();
                    context.rect(0, 0, canvas.width, canvas.height);
                    context.fillStyle = 'red';
                    context.fill();
                    document.getElementById('oreLegendAName').innerHTML = getOreName(myOreTypes.A.id);
                    document.getElementById('oreLegendA').style.display = 'inherit';
                }

                if (typeof myOreTypes.B !== 'undefined') {
                    var canvas = document.getElementById('oreLegendBCanvas');
                    var context = canvas.getContext('2d');
                    context.beginPath();
                    context.rect(0, 0, canvas.width, canvas.height);
                    context.fillStyle = 'green';
                    context.fill();
                    document.getElementById('oreLegendBName').innerHTML = getOreName(myOreTypes.B.id);
                    document.getElementById('oreLegendB').style.display = 'inherit';
                }

                if (typeof myOreTypes.C !== 'undefined') {
                    var canvas = document.getElementById('oreLegendCCanvas');
                    var context = canvas.getContext('2d');
                    context.beginPath();
                    context.rect(0, 0, canvas.width, canvas.height);
                    context.fillStyle = 'blue';
                    context.fill();
                    document.getElementById('oreLegendCName').innerHTML = getOreName(myOreTypes.C.id);
                    document.getElementById('oreLegendC').style.display = 'inherit';
                }

                runanimation();
            </script>

        </rm:defaultpage>
    </body>
</html>
