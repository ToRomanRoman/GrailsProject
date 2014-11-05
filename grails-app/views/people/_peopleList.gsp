<g:each in="${peopleInstanceList}" status="i" var="peopleInstance">
    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

        <td><g:link action="show" id="${peopleInstance.id}">${fieldValue(bean: peopleInstance, field: "name")}</g:link></td>

        <td>${fieldValue(bean: peopleInstance, field: "email")}</td>

        <td>${fieldValue(bean: peopleInstance, field: "adress")}</td>

    </tr>
</g:each>