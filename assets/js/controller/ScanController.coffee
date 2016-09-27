angular.module "application"
.controller "ScanController", ($rootScope, $scope, $mdSidenav, $mdToast, $mdDialog, $http, firebase, uuid)->
  # $scope.result = "9044,4572\n534,533\n528,523\n651,524\n524,524\n655,522\n525,650\n522,525\n526,520\n654,1579\n654,1659\n531,1661\n657,1660\n528,1660\n652,1673\n525,1658\n652,1662\n527,523\n653,1660\n537,1658\n525,646\n530,521\n529,646\n530,1661\n529,644\n530,1664\n528,646\n526,521\n526,1788\n527,1663\n527,1791\n458,524\n648,1659\n527,40287\n"
  $scope.result = ""
  $scope.name = ""

  $scope.scan = ->
    $scope.result = ""
    $http.get "/api/v1/scan"
    .success (data, status)->
      console.log data
      $scope.result = data.data
      $mdToast.show $mdToast.simple().textContent('success').hideDelay(3000)
    .error (data, status)->
      console.log data
      $mdToast.show $mdToast.simple().textContent('cause error').hideDelay(3000)

  $scope.send = ->
    $http.post "/api/v1/send", data: $scope.result
    .success (data, status)->
      console.log data
      $mdToast.show $mdToast.simple().textContent('success').hideDelay(3000)
    .error (data, status)->
      console.log data
      $mdToast.show $mdToast.simple().textContent('cause error').hideDelay(3000)

  $scope.save = (ev)->
    unless $scope.result
      $mdToast.show $mdToast.simple().textContent('スキャンしたデータがありません').hideDelay(3000)
      return
    confirm = $mdDialog.prompt()
      .title "名前をつけて保存"
      .textContent "名前を入力してください"
      .ariaLabel "name"
      .targetEvent ev
      .ok "保存"
      .cancel "キャンセル"
    $mdDialog.show(confirm).then (result)->
        $scope.name = result
        unless $scope.name
          $mdToast.show $mdToast.simple().textContent('名前を入力してください').hideDelay(3000)
          return
        u = uuid()
        firebase.database().ref "ir_demo/a/" + u
        .set
          uuid: u
          data: $scope.result
          name: $scope.name
        .then (data, status)->
          $mdToast.show $mdToast.simple().textContent('success').hideDelay(3000)
      , ()->
        console.log "close"
