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
        <script src='js/editcode.js'></script>
        <title>RoboMiner - Edit code</title>
    </head>
    <body>
        <script>window.onbeforeunload = confirmLooseChanges;</script>

        <input id='sourceNameOrig' type='hidden' value='${fn:escapeXml(programSource.sourceName)}'/>
        <textarea id='sourceCodeOrig' style='display: none;'>${fn:escapeXml(programSource.sourceCode)}</textarea>

        <rm:defaultpage currentform="editCode" username="${user.username}">

            <button class="helpbutton" onclick="window.open('<c:url value='help_index.html'/>')">help</button>

            <form id="eraseProgramSourceForm" action="<c:url value='editCode'/>" method="post">
                <input type="hidden" name="requestType" value="erase" />
                <input type="hidden" id="eraseProgramSourceId" name="programSourceId" value=""/>
            </form>

            <form id="changeProgramSourceForm" action="<c:url value='editCode'/>" method="post">
                <input type="hidden" name="requestType" value="change" />
                Edit code:
                <select id="programSourceId" name="nextProgramSourceId" onchange="selectOtherSource();">
                    <c:forEach var='programSourceItem' items='${user.programSourceList}'>
                        <option value="${programSourceItem.id}" ${programSourceItem.id eq programSourceId ? 'selected="selected"' : ''}>${fn:escapeXml(programSourceItem.sourceName)}</option>
                    </c:forEach>
                    <option value='-1' ${programSourceId le 0 ? 'selected="selected"' : ''}>New program</option>
                </select>
            </form>

            <br>

            <form id='editCodeForm' action="<c:url value='editCode'/>" method="post">
                <input type="hidden" name="requestType" value="update" />
                <input type="hidden" id="nextProgramSourceId" name="nextProgramSourceId" value="${programSourceId}"/>
                <input type="hidden" name="programSourceId" value="${programSourceId}"/>

                Program name:<br>
                <input id="sourceName" type="text" name="sourceName" value="${fn:escapeXml(programSource.sourceName)}" size="40" placeholder="Please choose a name for your program" required />
                <c:if test="${programSourceId gt 0 && programSource.robotList.size() eq 0}">
                    <input type="button" value="Delete" onclick="eraseProgram(${programSourceId});" />
                </c:if>
                <br>
                <br>

                Code:<br>
                <textarea id='sourceCode' name='sourceCode' rows='25' cols='100' onkeydown="return processTab(event, this);" required>${fn:escapeXml(programSource.sourceCode)}</textarea>
                <br>

                <c:if test="${not empty programSource.errorDescription}">
                    <p class="error">${fn:escapeXml(programSource.errorDescription)}</p>
                </c:if>

                <c:if test="${programSource.compiledSize ge 0}">
                    <p>Compiled size: ${programSource.compiledSize}</p>
                </c:if>

                <button onclick="submitData();">Save</button>
            </form>

        </rm:defaultpage>

        <c:choose>
            <c:when test="${not empty programSource.errorDescription}">
                <script>
                    alert(htmlDecode("${fn:escapeXml(programSource.errorDescription)}"));
                </script>
            </c:when>
            <c:when test="${not empty errorMessage}">
                <script>
                    alert(htmlDecode("${fn:escapeXml(errorMessage)}"));
                </script>
            </c:when>
        </c:choose>

    </body>
</html>
