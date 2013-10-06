angular.module('SessionService',[]).factory "Session",['$location','$http','$q', ($location ,$http ,$q) ->
  #Redirect to the given url (defaults '/')
  redirectTo = (url) ->
    url ||= '/'
    $location.path(url)

  service = {
    login: (email,password) ->
      return $http.post('/login',{user: {email: email, password: password}}

      ).then ((response) ->
        service.currentUser = response.data.user
        if(service.isAuthenticated())
          $location.path('/articles')

      ), (error) ->
        console.log(error)
    ,



    logout: (redirectURL) ->
      $http.post('/logout'
      ).then ->
        service.currentUser = null
        redirectTo(redirectURL)

    ,


  register: (email,password,confirm_password) ->
    return $http.post('/users.json',{user: {email: email, password: password, password_confirmation: confirm_password}}

    ).then ( (response) ->
      service.currentUser = response.data
      if(service.isAuthenticated())
        $location.path('/articles')
    ), (error) ->
      console.log(error)
  ,


  requestCurrentUser:  ->
    if (service.isAuthenticated())
      return $q.when(service.currentUser)
    else
      return $http.get('/current_user'

      ).then ( (response) ->

        service.currentUser = response.data.user
        return service.currentUser
      )
  ,


  currentUser: null,

  isAuthenticated: ->
    return !!service.currentUser

  }

  service


]