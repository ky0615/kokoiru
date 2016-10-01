angular.module "application"
.controller "SendController", ($rootScope, $scope, $stateParams, $http, $mdSidenav, $timeout, firebase, $mdDialog, $mdToast)->
  # ref = firebase.database().ref "ir_demo/a"

  # $scope.isUuid = ->
  #   $stateParams.uuid

  # $scope.send = ->
  #   $http.post "/api/v1/send", data: $scope.data.data
  #   .success (data, status)->
  #     console.log data
  #     $mdToast.show $mdToast.simple().textContent('success').hideDelay(3000)
  #   .error (data, status)->
  #     console.log data
  #     $mdToast.show $mdToast.simple().textContent('cause error').hideDelay(3000)

  # $scope.remove = (ev)->
  #   confirm = $mdDialog.confirm()
  #     .title $scope.data.name + "を削除する"
  #     .textContent "本当に削除しますか？"
  #     .ariaLabel "remove confirm"
  #     .targetEvent ev
  #     .ok "削除"
  #     .cancel "キャンセル"
  #   $mdDialog.show confirm
  #   .then ->
  #     ref.child $scope.data.uuid
  #     .remove()
  #     .then (res)->
  #       $mdToast.show $mdToast.simple().textContent('削除しました').hideDelay(3000)
  #   , ->
  #     console.log "cancel"

  # if $stateParams.uuid
  #   ref.child $stateParams.uuid
  #   .on "value", (data)->
  #     $timeout ->
  #       $scope.data = data.val()