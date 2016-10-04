angular.module "application"
  .controller "MessageController", ($rootScope, $scope, $mdSidenav, $state, $urlRouter, $location)->
    # console.log "Main"
    $scope.sendMessage = (mes)->
      console.log mes