angular.module("application").controller("IndexController", ["$rootScope", "$scope", "$http", "$interval", "$timeout", "$mdSidenav", "$mdToast", "socketio", function($rootScope, $scope, $http, $interval, $timeout, $mdSidenav, $mdToast, socketio) {
  var originatorEv;
  $scope.users = [];
  originatorEv = void 0;
  $scope.attend = function(user) {
    return console.log(user);
  };
  $scope.sortUsers = function() {
    $scope.setDiffTimeData();
    return $scope.users.sort(function(a, b) {
      if (b.leftFlag && a.leftFlag) {
        if (new Date(a.leftAt).getTime() < new Date(b.leftAt).getTime()) {
          return 1;
        } else {
          return -1;
        }
      }
      if (b.leftFlag) {
        return -1;
      } else {
        return 1;
      }
    });
  };
  $scope.getDiffTime = function(date) {
    var dx, dxAb, now, prefix, time, timeText;
    if (!date) {
      return date;
    }
    time = new Date(date);
    now = new Date();
    dx = now.getTime() - time.getTime();
    dxAb = dx < 0 ? dx * -1 : dx;
    prefix = "";
    timeText = "";
    dxAb = dxAb / 1000;
    if (dxAb < 10) {
      return "今";
    }
    if (dxAb < 60) {
      timeText = Math.floor(dxAb) + "秒";
    } else if (dxAb < 3600) {
      timeText = Math.floor(dxAb / 60) + "分";
    } else if (dxAb < 3600 * 24) {
      timeText = Math.floor(dxAb / 3600) + "時間";
    } else if (dxAb < 3600 * 24 * 360) {
      timeText = Math.floor(dxAb / 3600 / 24) + "日";
    } else {
      timeText = Math.floor(dxAb / 3600 / 24 / 360) + "年";
    }
    prefix = prefix + (dx < 0 ? "後" : "前");
    return timeText + prefix;
  };
  $scope.setDiffTimeData = function() {
    return $scope.users.map(function(val) {
      return val.diff = $scope.getDiffTime(val.leftAt);
    });
  };
  $interval($scope.setDiffTimeData, 1000);
  $scope.switchAttend = function(user) {
    return $http.post("/attend", user).success(function(result) {
      return $mdToast.showSimple("Change attend status was successful!");
    });
  };
  $scope.openMenu = function($mdOpenMenu, ev) {
    originatorEv = ev;
    return $mdOpenMenu(ev);
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
