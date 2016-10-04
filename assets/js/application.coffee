angular.module "application", ["ngMaterial", "ngResource", "ngMessages", "ui.router", "ui.bootstrap"]
.config ($stateProvider, $locationProvider, $urlRouterProvider, $mdThemingProvider)->
  $mdThemingProvider.theme('default').dark()
  $mdThemingProvider.theme('messageTextBox')
    .primaryPalette('pink')
    .accentPalette('orange')
  # $mdThemingProvider.theme('messageTextBox').dark false

  $locationProvider.html5Mode true
  $stateProvider
  .state "top",
    url: '/'
    templateUrl: 'templates/index.html'
    controller: 'IndexController'
  .state "message",
    url: "/message"
    templateUrl: "templates/message.html"
    controller: "MessageController"
  .state "main",
    abstract: true,
    templateUrl: 'templates/main.html'
    controller: 'MainController'
  .state "404",
    templateUrl: "templates/error.html"
    controller: "ErrorController"
    params: status: "404 Not Found"

  $urlRouterProvider
  .otherwise ($injector)->
    $injector.get("$state").go("404");

