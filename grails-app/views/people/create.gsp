<!DOCTYPE html>
<html>
	<head>
        <script type="text/javascript" src="http://scriptjava.net/source/scriptjava/scriptjava.js"></script>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'people.label', default: 'People')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
        <script type="text/javascript">
            function SendFile() {
                //отправка файла на сервер
                $$f({
                    formid:'test_form',//id формы
                    url:"${createLink(controller: 'people', action: 'uploadImage')}",
                    onstart:function () {//действие при начале загрузки файла
                        $$('result','начинаю отправку файла');//в элемент с id="result" выводим результат
                    },
                    onsend:function () {//действие по окончании загрузки файла
                        $$('result',$$('result').innerHTML+'<br />файл успешно загружен');//в элемент с id="result" выводим результат
                    }
                });
            }
        </script>

    </head>
	<body>
    <form id="test_form" method="post" enctype="multipart/form-data" onSubmit="">
        <input class="file_form" type="file" name="upload_file" />
    </form><br />
    <div id="result">Тут будет статус загрузки</div><br /><br />
    <div onclick="SendFile();">Отправить файл через Ajax</div><br />

    <a href="#create-people" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>

		<div id="create-people" class="content scaffold-create" role="main">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${peopleInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${peopleInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:peopleInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
