package com.auth

import grails.transaction.Transactional

@Transactional
class PeopleService {

    def searchPeopleByFilters(def params) {
        def searchFor = params.searchable
        def searchCategory = params.searchCategory
        def clientCriteria = People.createCriteria()
        def searchResults = clientCriteria.list(max: params.max, offset: params.offset, sort: params.sort, order: params.order){
            ilike("${searchCategory}", "${searchFor}%")
        }
        [searchResults: searchResults, searchResultSize: searchResults.getTotalCount()]
    }
}
