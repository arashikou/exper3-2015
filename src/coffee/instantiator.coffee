angular.module 'qbn.state', []
  .factory 'makeGameState', () ->
    # The immutable objects that make up the game itself serve as prototypes for the objects that
    # make up the mutable game state. This function takes a game definition object and makes a
    # mutable game state object out of it by wrapping it in a mutable property bag.
    #
    # By convention, any property on the prototype of the form "defaultThing" will be copied on the
    # instance as a property called "thing". This is to allow easy instantiation of default
    # starting values.
    (proto) ->
      instance = Object.create proto
      for key, value of proto when /^default\w/.test(key)
        [_, first, rest] = /^default(\w)(\w*)/.exec(key)
        newName = first.toLowerCase() + rest
        instance[newName] = value
      return instance
