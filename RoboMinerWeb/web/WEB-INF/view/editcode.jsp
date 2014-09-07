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

<script src='js/editcode.js'></script>

<button class="helpbutton" onclick="window.open('<c:url value='help_robotprogram.html'/>')">help</button>
<h1>Edit code</h1>

<form id="changeProgramSourceForm" action="<c:url value='editCode'/>" method="post">
    <select id="programSourceId" name="nextProgramSourceId" onchange="selectOtherSource();">
        <c:forEach var='programSourceItem' items='${programSourceList}'>
            <option value="${programSourceItem.id}" ${programSourceItem.id eq programSourceId ? 'selected="selected"' : ''}>${fn:escapeXml(programSourceItem.sourceName)}</option>
        </c:forEach>
        <option value='-1' ${programSourceId le 0 ? 'selected="selected"' : ''}>New program</option>
    </select>
</form>

<form id='editCodeForm' action="<c:url value='editCode'/>" method="post">
    <input type="hidden" name="programSourceId" value="${programSourceId}"/>
    <input type="hidden" id="nextProgramSourceId" name="nextProgramSourceId" value="${programSourceId}"/>
    <input id="sourceName" type="text" name="sourceName" value="${fn:escapeXml(programSource.sourceName)}" size="80"/><br/>
    <textarea id='sourceCode' name='sourceCode' rows='25' cols='120' onkeydown="return processTab(event, this);">${fn:escapeXml(programSource.sourceCode)}</textarea><br/>
    <c:if test="${not empty programSource.errorDescription}">
        <input type="text" value="${fn:escapeXml(programSource.errorDescription)}" readonly="true" size="80"/><br/>
    </c:if>
    <c:if test="${programSource.compiledSize ge 0}">
        Compiled size: <input type="text" value="${programSource.compiledSize}" readonly="true" size="6"/><br/>
    </c:if>
    <button onclick="submitData();">Save</button>
</form>

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

<input id='sourceNameOrig' type='hidden' value='${fn:escapeXml(programSource.sourceName)}'/>
<textarea id='sourceCodeOrig' style='display: none;'>${fn:escapeXml(programSource.sourceCode)}</textarea>

<script>window.onbeforeunload = confirmLooseChanges;</script>
