
<%@ page import="com.auth.People" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'people.label', default: 'People')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <g:javascript library="jquery_1.11.1"/>

	</head>
	<body>
		<a href="#list-people" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                <li><g:form action="imports" method="post" enctype="multipart/form-data">
                    <input name="data" type="file"><br>
                    <fieldset class="buttons">
                        <g:submitButton name="imports" class="save" value="imports" action="imports"/>
                    </fieldset>
                </g:form></li>
                <li><g:form method="post" enctype="multipart/form-data">
                    <input name="data" type="file"><br>
                    <fieldset class="buttons">
                        <g:submitToRemote url="[controller:'people', action:'imports']" update="peoples" value="imports"/>
                    </fieldset>
                </g:form></li>

<li><div class="search-bar">
    <g:form>
        <div class="list-label"><g:message code="default.list.label" args="[entityName]"/></div>
        Filter by:
        <g:select name="searchCategory"
                  from="${com.kreinium.Client$SearchCategories?.values()}"
                  keys="${com.kreinium.Client$SearchCategories.values()*.name()}"
                  required="" value="${searchCategory}"/>
        <input type="search" name="searchable" value="${searchKeyword}"/>
        <g:actionSubmit action="list" value="Search"/>
    </g:form>
</div></li>


                <li>${flash.messages}</li>
			</ul>
		</div>
		<div id="list-people" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'people.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="email" title="${message(code: 'people.email.label', default: 'Email')}" />
					
						<g:sortableColumn property="adress" title="${message(code: 'people.adress.label', default: 'Adress')}" />
					
					</tr>
				</thead>
				<tbody>

                <div id="peoples">
                    <g:render template="/people/peopleList"/>
                </div>


				</tbody>
			</table>

			<div class="pagination">
				<g:paginate total="${peopleInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
