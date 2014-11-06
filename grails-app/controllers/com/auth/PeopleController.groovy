package com.auth


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional
class PeopleController {
    @Transactional
    def search() {
        String text = params.textsearch
        List allpip = People.findAll()
        List<People> our = new ArrayList<People>()
        switch (params.select) {
            case 'name':
                for (People p : allpip) {
                    if (p.name.find(text)) {
                        our.add(p)
                    }
                }
                break
            case 'email':
                for (People p : allpip) {
                    if (p.email.find(text)) {
                        our.add(p)
                    }
                }
                break
            case 'adress':
                for (People p : allpip) {
                    if (p.adress.find(text)) {
                        our.add(p)
                    }
                }
                break
            default:
                println "error"
        }
        render sortList(our)
    }


    @Transactional
    def renderString() {
        String[] cs = params.textcsv.split(',')
        StringBuilder st = new StringBuilder();
        int count = 0
        if (cs.length % 3 == 0) {
            for (int i = 0; i < cs.length; i += 3) {
                new People(name: cs[i], email: cs[i + 1], adress: cs[i + 2]).save()
                count++
            }
        }
        render sortList(People.findAll())
    }

    //Whithout ajax
    @Deprecated
    @Transactional
    def imports() {

        int count = 0
        params.data.getInputStream().eachCsvLine { tokens ->
            for (int i = 0; i < tokens.length; i += 3) {
                if (new People(name: tokens[i], email: tokens[i + 1], adress: tokens[i + 2]).save()) {
                    ++count
                }
            }
        }
        flash.messages = message(code: 'default.message.import', args: [message(code: 'people.label', default: 'People'), count])
        session.peopleInstanceList = People.findAll()
        respond model: [peopleInstanceCount: People.count()]
    }

    private String sortList(List peoples) {
        StringBuilder st = new StringBuilder();
        for (People p : peoples) {
            st.append(" <tr class=\"even\"><td><a href=\"http://localhost:8080/Project/people/show/\"" + p.id + "\">" + p.name + "</a></td> <td>" + p.email + " </td><td>" + p.adress + "</td></tr>")
        }
        return st.toString()
    }

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond People.list(params), model: [peopleInstanceCount: People.count()]
    }

    def show(People peopleInstance) {
        respond peopleInstance
    }

    def create() {
        respond new People(params)
    }

    @Transactional
    def save(People peopleInstance) {
        if (peopleInstance == null) {
            notFound()
            return
        }

        if (peopleInstance.hasErrors()) {
            respond peopleInstance.errors, view: 'create'
            return
        }

        peopleInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'people.label', default: 'People'), peopleInstance.id])
                redirect peopleInstance
            }
            '*' { respond peopleInstance, [status: CREATED] }
        }
    }

    def edit(People peopleInstance) {
        respond peopleInstance
    }

    @Transactional
    def update(People peopleInstance) {
        if (peopleInstance == null) {
            notFound()
            return
        }

        if (peopleInstance.hasErrors()) {
            respond peopleInstance.errors, view: 'edit'
            return
        }

        peopleInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'People.label', default: 'People'), peopleInstance.id])
                redirect peopleInstance
            }
            '*' { respond peopleInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(People peopleInstance) {

        if (peopleInstance == null) {
            notFound()
            return
        }

        peopleInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'People.label', default: 'People'), peopleInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'people.label', default: 'People'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }


}
