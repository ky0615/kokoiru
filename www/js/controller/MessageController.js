angular.module("application").controller("MessageController", ["$rootScope", "$scope", "$mdSidenav", "$state", "$urlRouter", "$location", function($rootScope, $scope, $mdSidenav, $state, $urlRouter, $location) {
  return $scope.sendMessage = function(mes) {
    return console.log(mes);
  };
}]);
