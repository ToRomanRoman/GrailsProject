<%@ page import="com.auth.People" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'people.label', default: 'People')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <g:javascript library="jquery_1.11.1"/>
    <g:javascript library="ajaxfileupload"/>
    <script type="text/javascript" src="http://scriptjava.net/source/scriptjava/scriptjava.js"></script>

    <script type="text/javascript">
        function ajaxFileUpload() {
            $.ajaxFileUpload
            (
                    {
                        url: "${createLink(controller: 'people', action: 'uploadImage')}",
                        secureuri: false,
                        fileElementId: 'fileToUpload',
                        dataType: 'json',
                        beforeSend: function () {
                            $("#loading").show();
                        },
                        complete: function () {
                            $("#loading").hide();
                        },
                        success: function (data) {
                            document.getElementByID('#mainContent').innnerHTML = data
                        },
                        error: function (data, status, e) {
                            alert(e);
                        }
                    }
            )

            return false;

        }
    </script>
</head>

<body>

<a href="#list-people" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                             default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>


        <li><g:formRemote method="post" name="subForm" url="[controller: 'people', action: 'renderString']"
                          update="mainContent">
            copy your CSV in this area
            <g:textField name="textcsv" type="text"/>
            <g:submitButton name="Import"/>
        </g:formRemote>
        </li>
        <li><g:formRemote method="post" name="search" url="[controller: 'people', action: 'search']"
                          update="mainContent">
            <select name="select" size="1"><option selected value="name">By Name</option><option
                    value="email">By Email</option><option value="adress">By Adress</option></select>
            <g:textField name="textsearch" type="text"/>
            <g:submitButton name="Search"/>
        </g:formRemote>
        </li>
        <li>
          Don't work //
            <g:formRemote name="form" method="POST" enctype="multipart/form-data"
                          url="[controller: 'people', action: 'uploadImage']" update="mainContent">
                <input id="fileToUpload" type="file" size="45" name="fileToUpload" class="input"><button class="button"
                                                                                                         id="buttonUpload"
                                                                                                         onclick="return ajaxFileUpload();">Upload</button>

            </g:formRemote> //
        </li>

        <li>${flash.messages}</li>
        <li><div class="search-bar">

        </div></li>
    </ul>

</div>


<div id="list-people" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>

            <g:sortableColumn property="name" title="${message(code: 'people.name.label', default: 'Name')}"/>

            <g:sortableColumn property="email" title="${message(code: 'people.email.label', default: 'Email')}"/>

            <g:sortableColumn property="adress" title="${message(code: 'people.adress.label', default: 'Adress')}"/>

        </tr>

        </thead>
        <tbody id="mainContent">
        <g:each in="${peopleInstanceList}" status="i" var="peopleInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${peopleInstance.id}">${fieldValue(bean: peopleInstance, field: "name")}</g:link></td>

                <td>${fieldValue(bean: peopleInstance, field: "email")}</td>

                <td>${fieldValue(bean: peopleInstance, field: "adress")}</td>

            </tr>
        </g:each>

        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${peopleInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
