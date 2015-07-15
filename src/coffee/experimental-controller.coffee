qbnApp = angular.module 'qbnApp', []

class Quality
  constructor: (@name, @value) ->

class Storylet
  constructor: (@title) ->

class Choice
  constructor: (@text, @requirements) ->

qbnApp.controller 'QBN', ($scope) ->
  $scope.qualities = [
    new Quality 'Punchiness', 7
    new Quality 'Thinkyness', 2
  ]
  $scope.storylets = [
    new Storylet 'The Thinker\'s Apprentice'
    new Storylet 'Change Location'
    new Storylet 'A Mysterious Occurrence'
  ]
  $scope.eventText = 'Event'
  $scope.choices = [
    new Choice 'Choice A', 'Requires Punchiness 7'
    new Choice 'Choice B', 'Requires Thinkyness 5'
  ]
  $scope.currentStorylet = null;
  return
