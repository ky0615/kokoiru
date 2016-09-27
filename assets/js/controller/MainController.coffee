angular.module "application"
  .controller "MainController", ($rootScope, $scope, $mdSidenav, $state, $urlRouter, $location)->
    $scope.selectedIndex = undefined

    $scope.tabList = [
      title: "送信"
      link: "main.send"
      id: 0
    ,
      title:"スキャン"
      link: "main.scan"
      id: 1
    ]

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options)->
      for t in $scope.tabList
        if toState.name is t.link
          $scope.selectedIndex = t.id
          break

    $scope.$watch "selectedIndex", (current, old)->
      if current is undefined
        for t in $scope.tabList
          if $state.current.name is t.link
            $scope.selectedIndex = t.id
            break
        return
      $state.go $scope.tabList[current].link
