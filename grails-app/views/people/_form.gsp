<%@ page import="com.auth.People" %>



<div class="fieldcontain ${hasErrors(bean: peopleInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="people.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${peopleInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: peopleInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="people.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="email" required="" value="${peopleInstance?.email}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: peopleInstance, field: 'adress', 'error')} required">
	<label for="adress">
		<g:message code="people.adress.label" default="Adress" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="adress" required="" value="${peopleInstance?.adress}"/>

</div>

