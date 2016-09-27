angular.module("application").controller("SendController", ["$rootScope", "$scope", "$stateParams", "$http", "$mdSidenav", "$timeout", "firebase", "$mdDialog", "$mdToast", function($rootScope, $scope, $stateParams, $http, $mdSidenav, $timeout, firebase, $mdDialog, $mdToast) {
  var ref;
  ref = firebase.database().ref("ir_demo/a");
  $scope.isUuid = function() {
    return $stateParams.uuid;
  };
  $scope.send = function() {
    return $http.post("/api/v1/send", {
      data: $scope.data.data
    }).success(function(data, status) {
      console.log(data);
      return $mdToast.show($mdToast.simple().textContent('success').hideDelay(3000));
    }).error(function(data, status) {
      console.log(data);
      return $mdToast.show($mdToast.simple().textContent('cause error').hideDelay(3000));
    });
  };
  $scope.remove = function(ev) {
    var confirm;
    confirm = $mdDialog.confirm().title($scope.data.name + "を削除する").textContent("本当に削除しますか？").ariaLabel("remove confirm").targetEvent(ev).ok("削除").cancel("キャンセル");
    return $mdDialog.show(confirm).then(function() {
      return ref.child($scope.data.uuid).remove().then(function(res) {
        return $mdToast.show($mdToast.simple().textContent('削除しました').hideDelay(3000));
      });
    }, function() {
      return console.log("cancel");
    });
  };
  if ($stateParams.uuid) {
    return ref.child($stateParams.uuid).on("value", function(data) {
      return $timeout(function() {
        return $scope.data = data.val();
      });
    });
  }
}]);
