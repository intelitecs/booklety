@UsersController = ($scope,$location,$routeParams,User,$rootScope) ->
    $scope.searching = true
    $scope.message = "Here is the UsersController"
    $scope.errors = null

    #Getting all the user stored in the rootScope
    $scope.users = $rootScope.users
    $scope.user = null

    #Getting the user_page_param from the scope
    user_page_param = $routeParams.user_page_param
    $scope.$emit('routeLoaded',{user_page_param: user_page_param})
    $scope.dones = {}




    $scope.getAllSucessCallback = (response) ->
      $scope.users = response
      console.log("get all success reponse : #{response}")


    $scope.getOneSucessCallback = (response) ->
        $scope.user = response
        console.log("user for get's response is: #{$scope.user.username}  #{$scope.user.email}")

    $scope.createSuccessCallback = (response) ->
      console.log("user created successfully!")
      user = {id: response.id, username:response.username,email:response.email,comments:response.comments,created_at:response.created_at, updated_at:response.updated_at}
      $scope.user = user
      $scope.users.unshift(user)
      $scope.username = ""
      $scope.email = ""
      $scope.password = ""
      $scope.password_confirmation = ""
      $location.path("/")  #we can change the url with sucess message page, like welcome page

    $scope.updateSuccessCallback = (response) ->
      console.log("update success response: #{response}")
      for k,v of response
        console.log("#{k} : #{v}")

    $scope.deleteSuccessCallback = (response) ->
      console.log("delete success response: #{response}")
      for k,v of response
        console.log("#{k} : #{v}")


    $scope.createErrorCallback = (errors) ->
      if errors
        console.log(errors)
        console.log("server responded with status: #{errors.status}")
        username_errors =  errors.data.username
        email_errors    =  errors.data.email
        password_errors =  errors.data.password
        password_confirmation_errors = errors.data.password_confirmation
        $scope.errors = {username_errors: errors.data.username,email_errors:email_errors,password_errors:password_errors, password_confirmation_errors: password_confirmation_errors}

        if username_errors
          console.log("There are #{username_errors.length} errors on username attribute")
          for k,v of username_errors
            if k != "length"
              console.log("\t"+v)

        if email_errors
          console.log("There are #{email_errors.length} errors on email attribute")
          for k,v of email_errors
            if k != "length"
              console.log("\t"+v)

        if password_errors
          console.log("There are #{password_errors.length} errors on password attribute")
          for k,v of password_errors
            if k != "length"
              console.log("\t"+v)

        if password_confirmation_errors
          console.log("There are #{password_confirmation_errors.length} errors on password confirmation attribute")
          for k,v of password_confirmation_errors
            if k != "length"
              console.log("\t"+v)




    $scope.errorCallback = (errors) ->
      if errors
        console.log(errors)



    $scope.init = (successCallback,errorCallback) ->
      if((typeof successCallback is 'function') and (typeof errorCallback is 'function'))
        @userService = new User(successCallback,errorCallback)
      #$scope.users = @userService.all()

    #GET a user by its id
    $scope.get = (id) ->
      $scope.init($scope.getOneSucessCallback,$scope.errorCallback)
      @userService.get(id)


    #create a new user
    $scope.addUser = ->
      $scope.init($scope.createSuccessCallback,$scope.createErrorCallback)
      @userService.create({username: $scope.username, email: $scope.email, password: $scope.password, password_confirmation: $scope.password_confirmation})



    $scope.deleteUser = (user) ->
      $scope.init($scope.deleteSuccessCallback,$scope.errorCallback)
      @userService.delete(user)
      $scope.users.splice($scope.users.indexOf(user),1)

    $scope.updateUser = (user,data) ->
      $scope.init($scope.updateSuccessCallback,$scope.errorCallback)
      @userService.update(user,data)
      $scope.message = "compte #{user.username} modifié avec succès!"


    $scope.updateUserForId = (id,data) ->
      $scope.init($scope.updateSuccessCallback,$scope.errorCallback)
      user = _.findWhere $scope.users,{id: id}
      $scope.user = user
      $scope.updateUser(user,data)

    #$scope.updateUserForId(10,{username:'jean-charles',email:'charlies@yahoo.fr',password: 'jeancharles', password_confirmation:'jeancharles'})

    $scope.getDone = ->
      $scope.dones = _.filter $scope.users, (user) ->
        user.done

    $scope.new = ->
      $location.path('/users/new')


    $scope.deleteSelectedUsers = ->
      unless !confirm("Etes vous sure de supprimer #{$scope.dones.length} comptes?")
        for index,user of $scope.dones
          $scope.deleteUser(user)
        $scope.message =  "selection supprimée avec succès"

    $scope.displaySignUpForm = ->
      $("span.tooltip").hide()
      $location.path("/users/new")

    $scope.setCurrentUser = (user) ->
      $scope.user = user
      $location.path("/users/#{user.id}")


    $scope.show_user =(id)->
      $location.url("/users/"+id)
      if id?
        $scope.get(id)


    if $routeParams.id?
      $scope.show_user($routeParams.id)











