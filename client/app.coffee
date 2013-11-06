'use strict'

# Declare app level module which depends on filters, and services
angular.module('app', ['app.filters', 'app.services', 'app.directives'])
.config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $routeProvider

    .when '/',
      templateUrl: 'partials/index'
      controller:  IndexCtrl

    .when '/addPost',
      templateUrl: 'partials/addPost'
      controller:  AddPostCtrl

    .when '/readPost/:id',
      templateUrl: 'partials/readPost'
      controller:  ReadPostCtrl

    .when '/editPost/:id',
      templateUrl: 'partials/editPost'
      controller:  EditPostCtrl

    .when '/deletePost/:id',
      templateUrl: 'partials/deletePost'
      controller:  DeletePostCtrl

    .otherwise redirectTo: '/'

  $locationProvider.html5Mode true
  ]
