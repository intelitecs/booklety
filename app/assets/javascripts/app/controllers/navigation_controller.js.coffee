@NavigationController = ($scope) ->

  $scope.showLoginPage = ->
    $location.url('/login')

  $scope.showSignUpPage = ->
    $location.url('/signup')