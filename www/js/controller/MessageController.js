angular.module("application").controller("MessageController", ["$rootScope", "$scope", "$mdSidenav", "$mdToast", "$state", "$urlRouter", "$location", "$http", "socketio", function($rootScope, $scope, $mdSidenav, $mdToast, $state, $urlRouter, $location, $http, socketio) {
  $scope.sendingFlag = false;
  $scope.chatData = [];
  $scope.sendMessage = function(mes) {
    $scope.sendingFlag = true;
    return $http.post("/chat", mes).success(function(result) {
      $mdToast.showSimple("Post new Message was successful!");
      $scope.sendingFlag = false;
      return $scope.user.text = "";
    }).error(function(err) {
      $mdToast.showSimple("Cause error!");
      console.log(err);
      return $scope.sendingFlag = false;
    });
  };
  $http.get("/chat").success(function(result) {
    return $scope.chatData = result;
  });
  return socketio.on("changeChatData", function(data) {
    console.log(data);
    return $scope.chatData.unshift(data.data);
  });
}]);
