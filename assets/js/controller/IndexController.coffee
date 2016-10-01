angular.module "application"
.controller "IndexController", ($rootScope, $scope, $http, $mdSidenav)->
    $scope.users = []
    originatorEv = undefined

    $scope.attend = (user)->
        console.log user
    $scope.openMenu = ($mdOpenMenu, ev)->
        originatorEv = ev
        $mdOpenMenu ev

    $http.get "/users"
    .success (result)->
         $scope.users = result

