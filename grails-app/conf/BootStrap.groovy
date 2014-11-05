import com.auth.*


class BootStrap {

    def init = { servletContext ->
        def adminRole=Role.findOrSaveWhere(authority: 'ROLE_ADMIN')
        def user=User.findOrSaveWhere(username: 'roman@roman.by',password:'password')
        if(!user.authorities.contains(adminRole)){
            UserRole.create(user,adminRole,true)
        }
    }
    def destroy = {
    }
}
