angular.module("application").controller("RootController", ["$rootScope", "$scope", "$mdSidenav", "$timeout", "$state", function($rootScope, $scope, $mdSidenav, $timeout, $state) {
  $scope.pageList = [
    {
      name: "人のいちらん",
      path: "top"
    }, {
      name: "ひとことめっせーじ",
      path: "message"
    }
  ];
  $scope.toggleList = function() {
    return $mdSidenav("left").toggle();
  };
  return $scope.clickItem = function(item) {
    return $state.go(item.path);
  };
}]);
