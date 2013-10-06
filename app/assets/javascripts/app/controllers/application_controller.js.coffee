@ApplicationController = ($scope,$rootScope,$routeParams ,$location,$http) ->
  #Loads pages on startup
  #Loads users.json once, cache it into a variable and access to that variable when we need

  #Load users.json
  $http.get('/users.json'

  ).then ( (response) ->
    console.log(response)
    $rootScope.users = response.data
    console.log("users: #{$rootScope.users}")
  ), (error) ->
    console.log(error)



  #Load articles.json
  $http.get('/articles.json'

  ).then ((response) ->
    $rootScope.articles = response.data
    console.log("articles: #{$rootScope.articles}")
  ), (error) ->
    console.log(error)



  # Set the page parameter for menu active class
  #$scope.$on 'routeLoaded', (event,args) ->
  #  $scope.user_page_param = args.user_page_param
  #  $scope.article_page_param = args.article_page_param

