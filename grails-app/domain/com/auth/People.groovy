package com.auth

class People {

    String name
    String email
    String adress

    static constraints = {
        name(blank: false)
        email(email: true)
        adress(blank: false)
    }
    enum SearchCategories{
        name("Name"), email("Email"), adress("Adress")
    }
}
