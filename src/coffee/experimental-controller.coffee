qbnApp = angular.module 'qbnApp', []

class Quality
  constructor: (@name, @value) ->

class Choice
  constructor: (@text, @requirements) ->

qbnApp.controller 'QBN', ($scope) ->
  $scope.qualities = [
    new Quality 'Punchiness', 7
    new Quality 'Thinkyness', 2
  ]
  $scope.eventText = 'Event'
  $scope.choices = [
    new Choice 'Choice A', 'Requires Punchiness 7'
    new Choice 'Choice B', 'Requires Thinkyness 5'
  ]
  return
