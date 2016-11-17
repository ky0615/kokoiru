angular.module "application"
.controller "UserStatusModalController", ($rootScope, $scope, $http, $mdSidenav, $mdToast, $mdDialog, socketio, user)->
  $scope.user = user
  console.log user

  $scope.cancel = ->
    $mdDialog.cancel()
