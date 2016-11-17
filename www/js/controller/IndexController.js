angular.module("application").controller("IndexController", ["$rootScope", "$scope", "$http", "$mdSidenav", "$mdToast", "$mdDialog", "socketio", function($rootScope, $scope, $http, $mdSidenav, $mdToast, $mdDialog, socketio) {
  var originatorEv;
  $scope.users = [];
  originatorEv = void 0;
  $scope.attend = function(user) {
    return console.log(user);
  };
  $scope.sortUsers = function() {
    return $scope.users.sort(function(a, b) {
      if (b.leftFlag) {
        return -1;
      }
      return a.leftFlag;
    });
  };
  $scope.switchAttend = function(user) {
    return $http.post("/attend", user).success(function(result) {
      return $mdToast.showSimple("Change attend status was successful!");
    });
  };
  $scope.openMenu = function(ev, user) {
    return $scope.openUserStatus(ev, user);
  };
  $scope.openUserStatus = function(ev, user) {
    return $mdDialog.show({
      controller: "UserStatusModalController",
      templateUrl: "templates/userStatusModal.html",
      targetEvent: ev,
      clickOutsideToClose: true,
      locals: {
        user: user
      }
    }).then(function(res) {
      return console.log(res);
    });
  };
  $scope.loadUserList = function() {
    return $http.get("/users").success(function(result) {
      $scope.users = result;
      return $scope.sortUsers();
    });
  };
  $scope.loadUserList();
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
  socketio.on("reloadUserStatus", function(data) {
    console.log("reloadUserStatus");
    return $scope.loadUserList();
  });
  return socketio.on("disconnect", function() {
    return console.log("disconnect");
  });
}]);
