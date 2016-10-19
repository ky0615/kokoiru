angular.module "application"
.controller "IndexController", ($rootScope, $scope, $http, $mdSidenav, $mdToast, socketio)->
  $scope.users = []
  originatorEv = undefined

  $scope.attend = (user)->
    console.log user

  $scope.sortUsers = ->
    $scope.users.sort (a,b)->
      if b.leftFlag
        return -1
      return a.leftFlag

  $scope.switchAttend = (user)->
    $http.post "/attend", user
      .success (result)->
        $mdToast.showSimple "Change attend status was successful!"

  $scope.openMenu = ($mdOpenMenu, ev)->
    originatorEv = ev
    $mdOpenMenu ev

  $scope.loadUserList = ->
    $http.get "/users"
    .success (result)->
      $scope.users = result
      $scope.sortUsers()
  $scope.loadUserList()

  socketio.on "changeUserStatus", (data)->
    console.log data
    updateUser = $scope.users.find (user)->user.id is data.userId
    if updateUser
      updateUser.leftAt = data.leftAt
      updateUser.leftFlag = data.leftFlag
    $scope.sortUsers()

  socketio.on "changeUserData", (data)->
    console.log data
    switch data.status
      when "create"
        $scope.users.push data.data
      when "update"
        updateUser = $scope.users.find (user)->user.id is data.data.id
        if updateUser
          updateUser.name = data.data.name
          updateUser.number = data.data.number
    $scope.sortUsers()

  socketio.on "reloadUserStatus", (data)->
    console.log "reloadUserStatus"
    $scope.loadUserList()

  socketio.on "disconnect", ->
    console.log "disconnect"


