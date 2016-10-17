angular.module "application"
  .controller "MessageController", ($rootScope, $scope, $mdSidenav, $mdToast, $state, $urlRouter, $location, $http, socketio)->
    $scope.sendingFlag = false
    $scope.chatData = []
    $scope.sendMessage = (mes)->
      $scope.sendingFlag = true
      $http.post "/chat", mes
      .success (result)->
        $mdToast.showSimple "Post new Message was successful!"
        $scope.sendingFlag = false
        $scope.user.text = ""
      .error (err)->
        $mdToast.showSimple "Cause error!";
        console.log err
        $scope.sendingFlag = false

    $http.get "/chat"
    .success (result)->
      $scope.chatData = result

    socketio.on "changeChatData", (data)->
      console.log data
      $scope.chatData.unshift data.data