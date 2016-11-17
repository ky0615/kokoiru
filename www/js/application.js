angular.module("application", ["ngMaterial", "ngResource", "ngMessages", "ui.router", "ui.bootstrap", "calHeatmap"]).config(["$stateProvider", "$locationProvider", "$urlRouterProvider", "$mdThemingProvider", function($stateProvider, $locationProvider, $urlRouterProvider, $mdThemingProvider) {
  $mdThemingProvider.theme('default').dark();
  $mdThemingProvider.theme('messageTextBox').primaryPalette('pink').accentPalette('orange');
  $locationProvider.html5Mode(true);
  $stateProvider.state("top", {
    url: '/',
    templateUrl: 'templates/index.html',
    controller: 'IndexController'
  }).state("message", {
    url: "/message",
    templateUrl: "templates/message.html",
    controller: "MessageController"
  }).state("main", {
    abstract: true,
    templateUrl: 'templates/main.html',
    controller: 'MainController'
  }).state("404", {
    templateUrl: "templates/error.html",
    controller: "ErrorController",
    params: {
      status: "404 Not Found"
    }
  });
  return $urlRouterProvider.otherwise(function($injector) {
    return $injector.get("$state").go("404");
  });
}]);
