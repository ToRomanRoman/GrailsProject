
<%@ page import="com.auth.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-user" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="username" title="${message(code: 'user.username.label', default: 'Username')}" />
					
						<g:sortableColumn property="password" title="${message(code: 'user.password.label', default: 'Password')}" />
					
						<g:sortableColumn property="accountExpired" title="${message(code: 'user.accountExpired.label', default: 'Account Expired')}" />
					
						<g:sortableColumn property="accountLocked" title="${message(code: 'user.accountLocked.label', default: 'Account Locked')}" />
					
						<g:sortableColumn property="enabled" title="${message(code: 'user.enabled.label', default: 'Enabled')}" />
					
						<g:sortableColumn property="passwordExpired" title="${message(code: 'user.passwordExpired.label', default: 'Password Expired')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${userInstanceList}" status="i" var="userInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "username")}</g:link></td>
					
						<td>${fieldValue(bean: userInstance, field: "password")}</td>
					
						<td><g:formatBoolean boolean="${userInstance.accountExpired}" /></td>
					
						<td><g:formatBoolean boolean="${userInstance.accountLocked}" /></td>
					
						<td><g:formatBoolean boolean="${userInstance.enabled}" /></td>
					
						<td><g:formatBoolean boolean="${userInstance.passwordExpired}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${userInstanceCount ?: 0}" />
			</div>
            <tr>
                <g:if test="${!searchKeyword}">
                    <g:sortableColumn property="name" title="${message(code: 'client.lastName.label',
                            default: 'Name')}" />
                    <g:sortableColumn property="email" title="${message(code: 'client.firstName.label',
                            default: 'First Name')}" />
                    <g:sortableColumn property="adress" title="${message(code: 'client.middleName.label',
                            default: 'Middle Name')}" />
                </g:if>
                <g:else>
                    <g:sortableColumn property="naem" title="${message(code: 'client.lastName.label',
                            default: 'Name')}" params="searchCategory:searchCategory,searchable:searchKeyword]" />
                    <g:sortableColumn property="email" title="${message(code: 'client.firstName.label',
                            default: 'email')}" params="[searchCategory:searchCategory,searchable:searchKeyword]"/>
                    <g:sortableColumn property="adress" title="${message(code: 'client.middleName.label',
                            default: 'adress')}" params="[searchCategory:searchCategory,searchable:searchKeyword]"/>
                </g:else>
            </tr>
            <div class="pagination">
                <g:if test="${!searchKeyword}">
                    <g:paginate total="${peopleInstanceTotal}"/>
                </g:if>
                <g:else>
                    <g:paginate total="${peopleInstanceTotal}"
                                params="[searchCategory:searchCategory,searchable:searchKeyword]"/>
                </g:else>
            </div>
		</div>
	</body>
</html>
