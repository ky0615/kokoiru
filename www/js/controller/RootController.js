angular.module("application").controller("RootController", ["$rootScope", "$scope", "$mdSidenav", "$timeout", "$state", function($rootScope, $scope, $mdSidenav, $timeout, $state) {
  $scope.sendList = [];
  $scope.toggleList = function() {
    return $mdSidenav("left").toggle();
  };
  return $scope.clickItem = function(item) {
    console.log("click");
    console.log(item);
    return $state.go("main.send", {
      uuid: item.uuid
    });
  };
}]);
