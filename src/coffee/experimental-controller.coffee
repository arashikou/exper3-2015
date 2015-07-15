qbnApp = angular.module 'qbnApp', []

class Quality
  constructor: (@name, @defaultValue) ->

instantiate = (proto) ->
  instance = Object.create proto
  for key, value of proto when /^default\w{2}/.test(key)
    [_, first, rest] = /^default(\w)(\w*)/.exec(key)
    newName = first.toLowerCase() + rest
    instance[newName] = value
  return instance

class Storylet
  constructor: (@title, @text, @choices) ->

class Choice
  constructor: (@text, @requirements, @nextStorylet) ->

qbnApp.controller 'QBN', ($scope) ->
  $scope.qualities = [
    instantiate new Quality 'Punchiness', 7
    instantiate new Quality 'Thinkyness', 2
  ]
  $scope.storylets = [
    new Storylet 'The Thinker\'s Apprentice', 'You do some thinking.'
    new Storylet 'Change Location', 'Yeah, but where to go?'
    new Storylet 'A Mysterious Occurrence', 'So mysterious, you don\'t even know about it.'
  ]
  $scope.eventText = 'Event'
  $scope.choices = [
    new Choice 'Choice A', 'Requires Punchiness 7'
    new Choice 'Choice B', 'Requires Thinkyness 5'
  ]
  $scope.currentStorylet = null;
  return
