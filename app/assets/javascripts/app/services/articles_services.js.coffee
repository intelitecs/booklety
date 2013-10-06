BookLety.factory "ArticlesService",['$resource',($resource) ->
  ArticlesService = $resource '/Articles/:id',{id: '@id'},{update: {method: 'PUT'} }
  ArticlesService::save = ->
    if @id?
      @update()
    else
      @create()

  ArticlesService
]


BookLety.factory "ArticlesRailsService",['railsResourceFactory',(railsResourceFactory) ->
  ArticlesRailsService = railsResourceFactory({url: '/articles', name:'article'})
  ArticlesRailsService

]


BookLety.factory 'Article', ['$resource',($resource) ->
  class Article
    constructor:(successCallback,errorCallback) ->
      @service = $resource '/articles/:id',{id: '@id'},{update: {method: 'PATCH'}}
      @errorCallback = errorCallback
      @successCallback = successCallback
      @service::save = ->
        if @id?
          @update()
        else
          @create()


    create: (attrs) ->
      new @service(article: attrs).$save ((article) -> attrs.id = article.id),@successCallback, @errorCallback
      #attrs

    delete: (article) ->
      new @service().$delete {id: article.id}, @successCallback,@errorCallback

    update: (article,attrs) ->
      new @service(user: attrs).$update {id: article.id}, @successCallback, @errorCallback


    get: (id) ->
      @service.get {id: id},@successCallback, @errorCallback

    all: ->
      @service.query(@successCallback,@errorCallback)


]


