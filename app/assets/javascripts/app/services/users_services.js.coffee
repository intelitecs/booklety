BookLety.factory "UsersAngularService",['$resource',($resource) ->

  UsersAngularService = $resource '/users/:id',{id: '@id'},{update: {method: 'PUT'} }
  UsersAngularService::save = ->
    if @id?
      @update()
    else
      @create()

  UsersAngularService

]


BookLety.factory "UsersRailsService",['railsResourceFactory',(railsResourceFactory) ->
  UsersRailsService = railsResourceFactory({url: '/users', name:'user'})
  UsersRailsService

]


BookLety.factory 'User', ['$resource',($resource) ->
  class User
    constructor:(successCallback,errorCallback) ->
      @service = $resource '/users/:id',{id: '@id'},{update: {method: 'PATCH'}}
      @successCallback = successCallback
      @errorCallback = errorCallback
      @service::save = ->
        if @id?
          @update()
        else
          @create()



    create: (attrs) ->
      new @service(user: attrs).$save ((user) -> attrs.id = user.id),@successCallback, @errorCallback
      #attrs

    delete: (user) ->
      new @service().$delete {id: user.id}, @successCallback,@errorCallback

    #update a user
    update: (user,attrs) ->
      new @service(user: attrs).$update {id: user.id}, @successCallback, @errorCallback


    get: (id) ->
       @service.get {id: id},@successCallback, @errorCallback

    all: ->
      @service.query @successCallback, @errorCallback


]


