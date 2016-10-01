angular.module("application").controller("RootController", ["$rootScope", "$scope", "$mdSidenav", "$timeout", "$state", function($rootScope, $scope, $mdSidenav, $timeout, $state) {
  $scope.sendList = [];
  $scope.toggleList = function() {
    return $mdSidenav("left").toggle();
  };
  $scope.clickItem = function(item) {
    console.log("click");
    console.log(item);
    return $state.go("main.send", {
      uuid: item.uuid
    });
  };
  return $scope.removeItem = function(item) {
    console.log("remove");
    return console.log(item);
  };
}]);
