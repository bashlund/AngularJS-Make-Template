angular.module('NgApp')
    .config([
      '$locationProvider',
      '$routeProvider',
      function($locationProvider, $routeProvider) {
        "use strict";
        // routes
        $routeProvider.when("/",
          {
            templateUrl : "partials/index.html",
            controller : "MainController"
          })
          .otherwise({redirectTo : '/'});
        $locationProvider
          .html5Mode(false)
          .hashPrefix('!');
      }
    ]);
