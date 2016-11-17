angular.module("application").controller("UserStatusModalController", ["$rootScope", "$scope", "$http", "$mdSidenav", "$mdToast", "$mdDialog", "socketio", "user", function($rootScope, $scope, $http, $mdSidenav, $mdToast, $mdDialog, socketio, user) {
  $scope.user = user;
  console.log(user);
  return $scope.cancel = function() {
    return $mdDialog.cancel();
  };
}]);
