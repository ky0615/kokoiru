angular.module("application").controller("ErrorController", ["$rootScope", "$scope", "$state", function($rootScope, $scope, $state) {
  return $scope.text = $state.params.status;
}]);
