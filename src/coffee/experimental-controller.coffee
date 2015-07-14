qbnApp = angular.module 'qbnApp', []

qbnApp.controller 'QBN', ($scope) ->
  $scope.qualities =
    punchiness: "7"
    thinkyness: 2
  return
