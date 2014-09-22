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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="rm" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/robominer.css">
        <script src='js/robominer.js'></script>
        <script src='js/account.js'></script>
        <title>RoboMiner - Account</title>
    </head>
    <body>
        <rm:defaultpage currentform="account" username="${currentusername}">

            <rm:userassets oreassetlist="${oreAssetList}" user="${user}" />

            <form action="<c:url value='account'/>" method="post" onsubmit="return checkAccountForm(this);">
                <h1>${fn:escapeXml(currentusername)}</h1>
                <table>
                    <tr>
                        <td>Username:</td>
                        <td><input type="text" name="username" size="40" pattern="[A-Za-z0-9]{3,30}" value="${fn:escapeXml(user.username)}" required placeholder="Choose your in-game name"/></td>
                        <td>3 to 30 characters, only letters and numbers</td>
                    </tr>
                    <tr>
                        <td>e-mail address:</td>
                        <td><input type="email" name="email" size="40" value="${fn:escapeXml(user.email)}" required placeholder="Enter your e-mail address"/></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Current password:</td>
                        <td><input type="password" name="currentpassword" size="40" required placeholder="Your current password"/></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>New password:</td>
                        <td><input type="password" name="newpassword" size="40" pattern="^$|.{8,}" placeholder="New password, empty to leave unchanged"/></td>
                        <td>At least 8 characters</td>
                    </tr>
                    <tr>
                        <td>Confirm password:</td>
                        <td><input type="password" name="confirmpassword" size="40" placeholder="Confirm your new password"/></td>
                        <td></td>
                    </tr>
                </table>
                <c:if test="${not empty message}">
                    <p class="success">${fn:escapeXml(message)}</p>
                </c:if>
                <c:if test="${not empty errormessage}">
                    <p class="error">${fn:escapeXml(errormessage)}</p>
                </c:if>
                <input type="submit" value="Change"/>
            </form>
        </rm:defaultpage>
    </body>
</html>
