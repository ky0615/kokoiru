angular.module("application").controller("IndexController", ["$rootScope", "$scope", "$http", "$mdSidenav", function($rootScope, $scope, $http, $mdSidenav) {
  var originatorEv;
  $scope.users = [];
  originatorEv = void 0;
  $scope.attend = function(user) {
    return console.log(user);
  };
  $scope.openMenu = function($mdOpenMenu, ev) {
    originatorEv = ev;
    return $mdOpenMenu(ev);
  };
  return $http.get("/users").success(function(result) {
    return $scope.users = result;
  });
}]);
