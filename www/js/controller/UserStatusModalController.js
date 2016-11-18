angular.module("application").controller("UserStatusModalController", ["$rootScope", "$scope", "$http", "$mdSidenav", "$mdToast", "$mdDialog", "socketio", "user", "$timeout", function($rootScope, $scope, $http, $mdSidenav, $mdToast, $mdDialog, socketio, user, $timeout) {
  var now;
  $scope.showChangeInfo = false;
  $scope.user = user;
  $scope.changeUser = {
    name: user.name,
    number: user.number
  };
  now = new Date();
  $scope.heat = {
    domain: "month",
    domainLabelFormat: '%Y-%m',
    data: "/attend/" + user.id + "/heatmap",
    start: new Date(now.getFullYear(), now.getMonth() - 3),
    cellSize: 20,
    range: 4,
    highlight: "now",
    legend: [1, 2, 3, 4]
  };
  console.log(user);
  $scope.cancel = function() {
    return $mdDialog.cancel();
  };
  $scope.switchAttend = function(user) {
    return $http.post("/attend", user).success(function(result) {
      $mdToast.showSimple("Change attend status was successful!");
      return $scope.cancel();
    });
  };
  return $scope.switchChangeUserInfo = function($event) {
    if ($scope.showChangeInfo) {
      if (!$scope.changeUserValid.$valid) {
        $mdToast.showSimple("名前と学籍番号を入力してください");
        return;
      }
      $http.put("/users/" + $scope.changeUser.number, $scope.changeUser).success(function(result) {
        $mdToast.showSimple("Change user info was successful!");
        return $scope.cancel();
      });
    }
    return $scope.showChangeInfo = !$scope.showChangeInfo;
  };
}]);
