angular.module "application"
.controller "ScanController", ($rootScope, $scope, $mdSidenav, $mdToast, $mdDialog, $http, uuid)->
  $scope.result = ""
  $scope.name = ""

  # $scope.scan = ->
  #   $scope.result = ""
  #   $http.get "/api/v1/scan"
  #   .success (data, status)->
  #     console.log data
  #     $scope.result = data.data
  #     $mdToast.show $mdToast.simple().textContent('success').hideDelay(3000)
  #   .error (data, status)->
  #     console.log data
  #     $mdToast.show $mdToast.simple().textContent('cause error').hideDelay(3000)

  # $scope.send = ->
  #   $http.post "/api/v1/send", data: $scope.result
  #   .success (data, status)->
  #     console.log data
  #     $mdToast.show $mdToast.simple().textContent('success').hideDelay(3000)
  #   .error (data, status)->
  #     console.log data
  #     $mdToast.show $mdToast.simple().textContent('cause error').hideDelay(3000)

  # $scope.save = (ev)->
  #   unless $scope.result
  #     $mdToast.show $mdToast.simple().textContent('スキャンしたデータがありません').hideDelay(3000)
  #     return
  #   confirm = $mdDialog.prompt()
  #     .title "名前をつけて保存"
  #     .textContent "名前を入力してください"
  #     .ariaLabel "name"
  #     .targetEvent ev
  #     .ok "保存"
  #     .cancel "キャンセル"
  #   $mdDialog.show(confirm).then (result)->
  #       $scope.name = result
  #       unless $scope.name
  #         $mdToast.show $mdToast.simple().textContent('名前を入力してください').hideDelay(3000)
  #         return
  #       u = uuid()
  #       firebase.database().ref "ir_demo/a/" + u
  #       .set
  #         uuid: u
  #         data: $scope.result
  #         name: $scope.name
  #       .then (data, status)->
  #         $mdToast.show $mdToast.simple().textContent('success').hideDelay(3000)
  #     , ()->
  #       console.log "close"
