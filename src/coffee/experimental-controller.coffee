qbnApp = angular.module 'qbnApp', []

class Quality
  constructor: (@name, @value) ->

qbnApp.controller 'QBN', ($scope) ->
  $scope.qualities = [
    new Quality 'Punchiness', 7
    new Quality 'Thinkyness', 2
  ]
  return
