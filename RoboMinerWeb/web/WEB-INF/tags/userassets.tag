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

<%@ tag description="Show the ore assets" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="oreassetlist" required="true" type="java.util.List<nl.robominer.entity.UserOreAsset>"%>

<table class="oreassets">
    <caption>Assets</caption>
    <tr>
        <th class="oreassets">Ore</th>
        <th class="oreassets">Amount</th>
    </tr>
    <c:forEach var='oreAsset' items='${oreassetlist}'>
        <tr>
            <td class="oreassets">${fn:escapeXml(oreAsset.ore.oreName)}</td>
            <td class="oreassets">${oreAsset.amount}</td>
        </tr>
    </c:forEach>
</table>
