package com.auth


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional
class PeopleController {

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if(!params.searchable){
            flash.message = ""
            [ searchCategory:"",
              searchKeyword:"",
              peopleInstanceList: People.list(params),
              peopleInstanceTotal: People.count()]
        }else{
            def peoples = peopleService.searchPeoplesByFilters(params)
            flash.message = message(code: 'default.search.result.label', args: peoples.searchResultSize)
            [ searchCategory:params.searchCategory,
              searchKeyword: params.searchable ,
              clientInstanceList: peoples.searchResults ,
              clientInstanceTotal: peoples.searchResultSize]
        }
    }

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
        session.peopleInstanceList=People.findAll()
        respond  model: [peopleInstanceCount: People.count()]
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
