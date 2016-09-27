angular.module("application").controller("RootController", ["$rootScope", "$scope", "$mdSidenav", "firebase", "$timeout", "$state", function($rootScope, $scope, $mdSidenav, firebase, $timeout, $state) {
  var ref;
  ref = firebase.database().ref("ir_demo/a");
  $scope.sendList = [];
  $scope.toggleList = function() {
    return $mdSidenav("left").toggle();
  };
  $scope.clickItem = function(item) {
    console.log("click");
    console.log(item);
    return $state.go("main.send", {
      uuid: item.uuid
    });
  };
  $scope.removeItem = function(item) {
    console.log("remove");
    console.log(item);
    return ref.child(item.uuid).remove().then(function(res) {
      return console.log(res);
    });
  };
  return ref.on("value", function(res) {
    $scope.sendList = [];
    return $timeout(function() {
      var k, ref1, v;
      ref1 = res.val();
      for (k in ref1) {
        v = ref1[k];
        $scope.sendList.push(v);
      }
      return console.log($scope.sendList);
    });
  });
}]);
