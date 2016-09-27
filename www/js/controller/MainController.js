angular.module("application").controller("MainController", ["$rootScope", "$scope", "$mdSidenav", "$state", "$urlRouter", "$location", function($rootScope, $scope, $mdSidenav, $state, $urlRouter, $location) {
  $scope.selectedIndex = void 0;
  $scope.tabList = [
    {
      title: "送信",
      link: "main.send",
      id: 0
    }, {
      title: "スキャン",
      link: "main.scan",
      id: 1
    }
  ];
  $rootScope.$on('$stateChangeStart', function(event, toState, toParams, fromState, fromParams, options) {
    var i, len, ref, results, t;
    ref = $scope.tabList;
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      t = ref[i];
      if (toState.name === t.link) {
        $scope.selectedIndex = t.id;
        break;
      } else {
        results.push(void 0);
      }
    }
    return results;
  });
  return $scope.$watch("selectedIndex", function(current, old) {
    var i, len, ref, t;
    if (current === void 0) {
      ref = $scope.tabList;
      for (i = 0, len = ref.length; i < len; i++) {
        t = ref[i];
        if ($state.current.name === t.link) {
          $scope.selectedIndex = t.id;
          break;
        }
      }
      return;
    }
    return $state.go($scope.tabList[current].link);
  });
}]);
