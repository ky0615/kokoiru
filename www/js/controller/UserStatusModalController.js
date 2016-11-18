angular.module("application").controller("UserStatusModalController", ["$rootScope", "$scope", "$http", "$mdSidenav", "$mdToast", "$mdDialog", "socketio", "user", "$timeout", function($rootScope, $scope, $http, $mdSidenav, $mdToast, $mdDialog, socketio, user, $timeout) {
  var now;
  $scope.user = user;
  now = new Date();
  $scope.heat = {
    domain: "month",
    domainLabelFormat: '%Y-%m',
    data: "/attend/" + user.id + "/heatmap",
    start: new Date(now.getFullYear(), now.getMonth() - 11),
    cellSize: 20,
    range: 12,
    highlight: "now",
    legend: [1, 2, 3, 4]
  };
  console.log(user);
  $scope.cancel = function() {
    return $mdDialog.cancel();
  };
  return $scope.switchAttend = function(user) {
    return $http.post("/attend", user).success(function(result) {
      $mdToast.showSimple("Change attend status was successful!");
      return $scope.cancel();
    });
  };
}]);
