# The immutable objects that make up the game itself serve as prototypes for the objects that make
# up the mutable game state. This function takes a game definition object and makes a state
# instance of it.
#
# By convention, any property on the prototype of the form "defaultThing" will be copied on the
# instance as a property called "thing". This is to allow easy instantiation of default, starting
# values.
instantiate = (proto) ->
  instance = Object.create proto
  for key, value of proto when /^default\w/.test(key)
    [_, first, rest] = /^default(\w)(\w*)/.exec(key)
    newName = first.toLowerCase() + rest
    instance[newName] = value
  return instance

angular.module 'qbn.engine', ['qbn.quality', 'qbn.storylet']
  .factory 'storyletFilter', (qualityLibrary, storyletLibrary) ->
    () ->
  .controller 'QBN', ($scope, storyletFilter) ->
    $scope.qualities = [
      instantiate new Quality 'Punchiness', '', 7
      instantiate new Quality 'Thinkyness', '', 2
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
