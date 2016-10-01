angular.module "application", ["ngMaterial", "ngResource", "ngMessages", "ui.router", "ui.bootstrap"]
.config ($stateProvider, $locationProvider, $urlRouterProvider, $mdThemingProvider)->
  $mdThemingProvider.theme('default').dark()

  $locationProvider.html5Mode true
  $stateProvider
  .state "top",
    url: '/'
    templateUrl: 'templates/index.html'
    controller: 'IndexController'
  .state "main",
    abstract: true,
    templateUrl: 'templates/main.html'
    controller: 'MainController'
  .state "main.send",
    url: '/send/:uuid'
    templateUrl: 'templates/send.html'
    controller: 'SendController'
  .state "main.scan",
    url: '/scan'
    templateUrl: 'templates/scan.html'
    controller: 'ScanController'
  .state "404",
    templateUrl: "templates/error.html"
    controller: "ErrorController"
    params: status: "404 Not Found"

  $urlRouterProvider
  .otherwise ($injector)->
    $injector.get("$state").go("404");

