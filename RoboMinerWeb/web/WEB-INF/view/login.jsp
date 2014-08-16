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
<script>
    function checkSignupForm(form) {
        if (form.newpassword.value !== form.confirmpassword.value) {
            alert("Passwords don't match");
            form.newpassword.focus();
            return false;
        }
        
        return true;
    }
</script>
<header>
    <nav>
        <ul class="menubar">
            <li class="menuitem" onclick="showPart('loginForm'); hidePart('signupForm');"><p class="menuitemtext">Login</p></li>
            <li class="menuitem" onclick="showPart('signupForm'); hidePart('loginForm');"><p class="menuitemtext">Sign up</p></li>
        </ul>
    </nav>
</header>
<div id="interface">               
    <form id="loginForm" action="<c:url value='Login'/>" method="post" ${empty errorMessage ? '' : 'style="display: none;"'}>
        <h1>Login</h1>
        <table>
            <tr>
                <td>Login name:</td>
                <td><input type="text" name="loginName" size="40" value="${fn:escapeXml(loginName)}" required placeholder="Please enter your username or e-mail address" ${empty loginName ? 'autofocus="autofocus"' : ''} /></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type="password" name="password" size="40" value="" required placeholder="Please enter your password" ${empty loginName ? '' : 'autofocus="autofocus"'} /></td>
            </tr>
            <tr>
                <td/>
                <td>
                    <input type="checkbox" name="remember" value="remember" ${empty loginName ? '' : 'checked'}/>Remember login name
                </td>
            </tr>
        </table>
        <input type='submit' value='Log in'/>
        <br>
        <p>No account yet? <a href="#" onclick="showPart('signupForm'); hidePart('loginForm');">Sign up</a> for free.</p>
    </form>
    <form id="signupForm" action="<c:url value='Login'/>" method="post" ${empty errorMessage ? 'style="display: none;"' : ''} onsubmit="return checkSignupForm(this);">
        <h1>Sign up</h1>
        <c:if test="${not empty errorMessage}">
            <p class="error">${fn:escapeXml(errorMessage)}</p>
        </c:if>
        <table>
            <tr>
                <td>Username:</td>
                <td><input type="text" name="newusername" size="40" pattern="[A-Za-z0-9]{6,30}" value="${fn:escapeXml(newusername)}" required placeholder="Choose your in-game name"/></td>
                <td>6 to 30 characters, only letters and numbers</td>
            </tr>
            <tr>
                <td>e-mail address:</td>
                <td><input type="email" name="email" size="40" value="${fn:escapeXml(email)}" required placeholder="Enter your e-mail address"/></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type="password" name="newpassword" size="40" pattern=".{8,}" required placeholder="Choose a password"/></td>
                <td>At least 8 characters</td>
            </tr>
            <tr>
                <td>Confirm password:</td><td><input type="password" name="confirmpassword" size="40" required placeholder="Confirm your password"/></td>
            </tr>
        </table>
        <input type="submit" value="Sign up"/>
    </form>
