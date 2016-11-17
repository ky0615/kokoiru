angular.module "application"
.controller "IndexController", ($rootScope, $scope, $http, $interval, $timeout, $mdSidenav, $mdDialog, $mdToast, socketio)->
  $scope.users = []
  originatorEv = undefined

  $scope.attend = (user)->
    console.log user

  $scope.sortUsers = ->
    $scope.setDiffTimeData()
    $scope.users.sort (a,b)->
      if b.leftFlag and a.leftFlag
        return if new Date(a.leftAt).getTime() < new Date(b.leftAt).getTime() then 1 else -1
      return if b.leftFlag then -1 else 1

  $scope.getDiffTime = (date)->
    unless date
      return date

    time = new Date date
    now = new Date()
    dx = now.getTime() - time.getTime()
    dxAb = if dx < 0 then dx * -1 else dx
    prefix = ""
    timeText = ""

    # convert ms to second
    dxAb = dxAb / (1000)

    if dxAb < 10
      return "今"
    if dxAb < 60
      timeText = Math.floor(dxAb) + "秒"
    else if dxAb < 3600
      timeText = Math.floor(dxAb/60) + "分"
    else if dxAb < 3600 * 24
      timeText = Math.floor(dxAb/3600) + "時間"
    else if dxAb < 3600 * 24 * 360
      timeText = Math.floor(dxAb/3600/24) + "日"
    else
      timeText = Math.floor(dxAb/3600/24/360) + "年"

    prefix = prefix + if dx < 0 then "後" else "前"
    return timeText + prefix

  $scope.setDiffTimeData = ->
    $scope.users.map (val)->
      val.diff = $scope.getDiffTime val.leftAt
  $interval $scope.setDiffTimeData, 1000

  $scope.switchAttend = (user)->
    $http.post "/attend", user
      .success (result)->
        $mdToast.showSimple "Change attend status was successful!"

  $scope.openMenu = (ev, user)->
    # originatorEv = ev
    # $mdOpenMenu ev
    $scope.openUserStatus ev, user

  $scope.openUserStatus = (ev, user)->
    $mdDialog.show
      controller: "UserStatusModalController"
      templateUrl: "templates/userStatusModal.html"
      targetEvent: ev
      clickOutsideToClose: true
      locals:
        user: user
    .then (res)->
      console.log res
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
