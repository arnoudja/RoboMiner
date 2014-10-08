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

<%@ tag description="Convert a period in seconds to a readable format" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ attribute name="seconds" required="true" %>

<c:choose>
    <c:when test="${seconds % 3600 eq 0 && seconds gt 3600}">
        <fmt:formatNumber value="${seconds / 3600}" maxFractionDigits="0" /> hours
    </c:when>
    <c:when test="${seconds % 60 eq 0 && seconds gt 60}">
        <fmt:formatNumber value="${seconds / 60}" maxFractionDigits="0" /> minutes
    </c:when>
    <c:otherwise>
        ${seconds} seconds
    </c:otherwise>
</c:choose>
