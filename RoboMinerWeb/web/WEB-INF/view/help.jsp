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

<%@ taglib prefix="rm" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/robominer.css">
        <script src='js/robominer.js'></script>
        <script src='js/account.js'></script>
        <title>RoboMiner - Activity</title>
    </head>
    <body>
        <rm:defaultpage currentform="help" username="${user.username}">
            <h1>Help index</h1>
            <p>
                The following help texts can help you improve your mining robot.
            </p>
            <h2>New to RoboMiner?</h2>
            <p>
                Then the <a href="help_tutorial.html" target="tutorialWindow">Tutorial</a> is a good start!
                It contains a step-by-step explanation of how to start playing RoboMiner.
            </p>
            <h2>Need help with improving the Robot program?</h2>
            <p>
                The <a href="help_programtips.html" target="programTipsWindow">Robot programming tips and tricks</a>
                contains some nice examples on how to program your Robot to mine more ore.
            </p>
            <p>
                If you want to program your Robot without any spoilers you might want to skip this section.
            </p>
            <h2>The Robot programming language</h2>
            <p>
                The <a href="help_robotprogram.html" target="robotProgramWindow">Robot programming language description</a>
                contains an explanation about the syntax and options of the Robot programming language.
            </p>
            <h2>The Mechanics</h2>
            <p>
                Want to know what's the meaning of all those numbers shown in the Shop?
                And want to know how they affect your Robots performance?
                Then you can check out the
                <a href="help_mechanics.html" target="mechanicsWindow">Mechanics Guide</a>.
            </p>
        </rm:defaultpage>
    </body>
</html>
