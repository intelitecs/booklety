# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.

#= require jquery
#= require jquery_ujs
# require turbolinks

#= require foundation
#= require underscore
#= require angular
#= require angular-resource
#= require angular-file-upload
#= require angular-ui-router

#= require angularjs/rails/resource/index
#= require angularjs/rails/resource/resource
#= require angularjs/rails/resource/serialization
#= require angularjs/rails/resource/utils/inflector
#= require angularjs/rails/resource/utils/injector
#= require angularjs/rails/resource/utils/url_builder


#= require_tree .
#

#= require_tree .



$ ->
  $(document).foundation()









