class Storylet
  constructor: (@id, @title, @text, @choices, @frontFacingChoice) ->
    Object.freeze @

  isVisibleWith: (qualityLibrary) -> frontFacingChoice?.isVisibleWith qualityLibrary

class Choice
  constructor: (@title, @text, @visibleReqs, @activeReqs, @next) ->

  reqsAreMet = (reqs, qualityLibrary) ->
    for qualityName, predicate of reqs
      quality = qualityLibrary.resolve qualityName
      return false unless predicate quality
    return true

  isVisibleWith: (qualityLibrary) ->
    reqsAreMet @visibleReqs, qualityLibrary

  isActiveWith: (qualityLibrary) ->
    reqsAreMet @activeReqs, qualityLibrary

angular.module 'qbn.storylet', ['qbn.state', 'qbn.quality']
  .factory 'storyletLibrary', (makeGameState, qualityLibrary) ->
    library = {}
    api =
      register: (args...) ->
        storylet = new Storylet args...
        library[storylet.id] = storylet # Storylets are stored in immutable form
        return this # Allow Chaining
      resolve: (q) ->
        if q instanceof Storylet
          q
        else
          library[q.toString()]
      getAllFrontFacing: () ->
        for _, storylet of library when storylet.isVisibleWith qualityLibrary
          stateStorylet = makeGameState storylet
          stateStorylet.canRetreat = true
          stateStorylet
    return Object.freeze api
  .factory 'choiceFactory', () ->
    (args...) -> new Choice args...
