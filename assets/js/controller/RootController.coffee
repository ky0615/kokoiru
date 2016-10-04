angular.module "application"
.controller "RootController", ($rootScope, $scope, $mdSidenav, $timeout, $state)->
  $scope.pageList = [
    name: "人のいちらん"
    path: "top"
  ,
    name: "ひとことめっせーじ"
    path: "message"
  ]

  $scope.toggleList = ->
      $mdSidenav("left").toggle()

  $scope.clickItem = (item)->
    $state.go item.path
