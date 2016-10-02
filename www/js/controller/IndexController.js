angular.module("application").controller("IndexController", ["$rootScope", "$scope", "$http", "$mdSidenav", "$mdToast", "socketio", function($rootScope, $scope, $http, $mdSidenav, $mdToast, socketio) {
  var originatorEv;
  $scope.users = [];
  originatorEv = void 0;
  $scope.attend = function(user) {
    return console.log(user);
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
    return $scope.users = result;
  });
  socketio.on("changeUserStatus", function(data) {
    var updateUser;
    console.log(data);
    updateUser = $scope.users.find(function(user) {
      return user.id === data.userId;
    });
    if (updateUser) {
      updateUser.leftAt = data.leftAt;
      return updateUser.leftFlag = data.leftFlag;
    }
  });
  socketio.on("changeUserData", function(data) {
    var updateUser;
    console.log(data);
    switch (data.status) {
      case "create":
        return $scope.users.push(data.data);
      case "update":
        updateUser = $scope.users.find(function(user) {
          return user.id === data.data.id;
        });
        if (updateUser) {
          updateUser.name = data.data.name;
          return updateUser.number = data.data.number;
        }
    }
  });
  return socketio.on("disconnect", function() {
    return console.log("disconnect");
  });
}]);
