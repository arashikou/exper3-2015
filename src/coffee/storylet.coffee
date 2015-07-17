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

angular.module 'qbn.storylet', ['qbn.quality']
  .factory 'storyletLibrary', (qualityLibrary) ->
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
        storylet for _, storylet of library when storylet.isVisibleWith qualityLibrary
    return Object.freeze api
  .factory 'choiceFactory', () ->
    (args...) -> new Choice args...
