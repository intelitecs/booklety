#= require_self

@BookLety = angular.module("BookLety",['ngResource','SessionService','rails'])

$(document).on 'page:load', ->
  $('[ng-app]').each ->
    module = $(this).attr('ng-app')
    angular.bootstrap(this,[module])

