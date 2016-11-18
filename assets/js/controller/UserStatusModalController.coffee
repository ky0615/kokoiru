angular.module "application"
.controller "UserStatusModalController", ($rootScope, $scope, $http, $mdSidenav, $mdToast, $mdDialog, socketio, user, $timeout)->
  $scope.showChangeInfo = false
  $scope.user = user

  $scope.changeUser =
    name: user.name
    number: user.number

  now = new Date()

  $scope.heat =
    domain: "month"
    domainLabelFormat: '%Y-%m'
    data: "/attend/#{user.id}/heatmap"
    start: new Date now.getFullYear(), now.getMonth() - 3
    cellSize: 20
    range: 4
    highlight: "now"
    legend: [1, 2, 3, 4]

  console.log user

  $scope.cancel = ->
    $mdDialog.cancel()

  $scope.switchAttend = (user)->
    $http.post "/attend", user
    .success (result)->
      $mdToast.showSimple "Change attend status was successful!"
      $scope.cancel()

  $scope.switchChangeUserInfo = ($event)->
    if $scope.showChangeInfo
      if !$scope.changeUserValid.$valid
        $mdToast.showSimple "名前と学籍番号を入力してください"
        return
      $http.put "/users/#{$scope.changeUser.number}", $scope.changeUser
      .success (result)->
        $mdToast.showSimple "Change user info was successful!"
        $scope.cancel()
    $scope.showChangeInfo = !$scope.showChangeInfo

