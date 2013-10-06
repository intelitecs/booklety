BookLety.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
  $httpProvider.defaults.headers.patch ||=  {}
  $httpProvider.defaults.headers.patch['Content-Type'] = 'application/json'


