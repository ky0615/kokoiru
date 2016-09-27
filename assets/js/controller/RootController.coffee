angular.module "application"
.controller "RootController", ($rootScope, $scope, $mdSidenav, firebase, $timeout, $state)->
  ref = firebase.database().ref "ir_demo/a"
  $scope.sendList = []
  $scope.toggleList = ->
      $mdSidenav("left").toggle()

  $scope.clickItem = (item)->
    console.log "click"
    console.log item
    $state.go "main.send", 
      uuid:item.uuid

  $scope.removeItem = (item)->
    console.log "remove"
    console.log item
    ref.child item.uuid
    .remove()
    .then (res)->
      console.log res

  ref.on "value", (res)->
    $scope.sendList = []
    $timeout ->
      for k, v of res.val()
        $scope.sendList.push v
      console.log $scope.sendList
  # ref.on "child_added", (res)->
  #   console.log "added"
  #   console.log res.val()


