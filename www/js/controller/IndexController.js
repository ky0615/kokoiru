angular.module("application").controller("IndexController", ["$rootScope", "$scope", "$http", "$mdSidenav", "$mdToast", "socketio", function($rootScope, $scope, $http, $mdSidenav, $mdToast, socketio) {
  var originatorEv;
  $scope.users = [];
  originatorEv = void 0;
  $scope.attend = function(user) {
    return console.log(user);
  };
  $scope.sortUsers = function() {
    return $scope.users.sort(function(a, b) {
      return a.leftFlag;
    });
  };
  $scope.switchAttend = function(user) {
    return $http.post("/attend", user).success(function(result) {
      return $mdToast.showSimple("Change attend status was successful!");
    });
  };
  $scope.openMenu = function($mdOpenMenu, ev) {
    originatorEv = ev;
    return $mdOpenMenu(ev);
  };
  $http.get("/users").success(function(result) {
    $scope.users = result;
    return $scope.sortUsers();
  });
  socketio.on("changeUserStatus", function(data) {
    var updateUser;
    console.log(data);
    updateUser = $scope.users.find(function(user) {
      return user.id === data.userId;
    });
    if (updateUser) {
      updateUser.leftAt = data.leftAt;
      updateUser.leftFlag = data.leftFlag;
    }
    return $scope.sortUsers();
  });
  socketio.on("changeUserData", function(data) {
    var updateUser;
    console.log(data);
    switch (data.status) {
      case "create":
        $scope.users.push(data.data);
        break;
      case "update":
        updateUser = $scope.users.find(function(user) {
          return user.id === data.data.id;
        });
        if (updateUser) {
          updateUser.name = data.data.name;
          updateUser.number = data.data.number;
        }
    }
    return $scope.sortUsers();
  });
  return socketio.on("disconnect", function() {
    return console.log("disconnect");
  });
}]);
