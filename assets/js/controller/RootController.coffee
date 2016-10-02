angular.module "application"
.controller "RootController", ($rootScope, $scope, $mdSidenav, $timeout, $state)->
  $scope.sendList = []
  $scope.toggleList = ->
      $mdSidenav("left").toggle()

  $scope.clickItem = (item)->
    console.log "click"
    console.log item
    $state.go "main.send", 
      uuid:item.uuid
