class Storylet
  constructor: (@id, @title, @text, @choices, @frontFacingChoice) ->
    Object.freeze @

  isVisibleWith: (qualities) -> frontFacingChoice?.isVisibleWith qualities

class Choice
  constructor: (@title, @text, @visibleReqs, @activeReqs, @next) ->

  isVisibleWith: (qualities) ->

  isActiveWith: (qualities) ->

angular.module 'qbn.storylet', []
  .factory 'storyletLibrary', () ->
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
      filterVisible: (qualities) ->
        storylet for _, storylet of library when storylet.isVisibleWith qualities
    return Object.freeze api
  .factory 'choiceFactory', () ->
    (args...) -> new Choice args...
