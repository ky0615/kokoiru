angular.module("application").controller("ScanController", ["$rootScope", "$scope", "$mdSidenav", "$mdToast", "$mdDialog", "$http", "firebase", "uuid", function($rootScope, $scope, $mdSidenav, $mdToast, $mdDialog, $http, firebase, uuid) {
  $scope.result = "";
  $scope.name = "";
  $scope.scan = function() {
    $scope.result = "";
    return $http.get("/api/v1/scan").success(function(data, status) {
      console.log(data);
      $scope.result = data.data;
      return $mdToast.show($mdToast.simple().textContent('success').hideDelay(3000));
    }).error(function(data, status) {
      console.log(data);
      return $mdToast.show($mdToast.simple().textContent('cause error').hideDelay(3000));
    });
  };
  $scope.send = function() {
    return $http.post("/api/v1/send", {
      data: $scope.result
    }).success(function(data, status) {
      console.log(data);
      return $mdToast.show($mdToast.simple().textContent('success').hideDelay(3000));
    }).error(function(data, status) {
      console.log(data);
      return $mdToast.show($mdToast.simple().textContent('cause error').hideDelay(3000));
    });
  };
  return $scope.save = function(ev) {
    var confirm;
    if (!$scope.result) {
      $mdToast.show($mdToast.simple().textContent('スキャンしたデータがありません').hideDelay(3000));
      return;
    }
    confirm = $mdDialog.prompt().title("名前をつけて保存").textContent("名前を入力してください").ariaLabel("name").targetEvent(ev).ok("保存").cancel("キャンセル");
    return $mdDialog.show(confirm).then(function(result) {
      var u;
      $scope.name = result;
      if (!$scope.name) {
        $mdToast.show($mdToast.simple().textContent('名前を入力してください').hideDelay(3000));
        return;
      }
      u = uuid();
      return firebase.database().ref("ir_demo/a/" + u).set({
        uuid: u,
        data: $scope.result,
        name: $scope.name
      }).then(function(data, status) {
        return $mdToast.show($mdToast.simple().textContent('success').hideDelay(3000));
      });
    }, function() {
      return console.log("close");
    });
  };
}]);
