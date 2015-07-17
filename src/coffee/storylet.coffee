edsl = (id, title, text, choices = [], args = {}) ->
  {frontFacingChoice} = args
  Object.freeze new Storylet(id, title, text, choices, frontFacingChoice)

class Storylet
  constructor: (@id, @title, @text, @choices, @frontFacingChoice) ->

  isVisibleWith: (qualities) -> frontFacingChoice?.isVisibleWith(qualities)

  class Choice
    constructor: (@title, @text, @visibleReqs, @activeReqs, @next) ->

    isVisibleWith: (qualities) ->

    isActiveWith: (qualities) ->

angular.module 'qbn.storylet', []
  .factory 'storyletLibrary', () ->
    library = {}
    api =
      register: (id, title, text, options) ->
        storylet = new Storylet()
        library[id] = Object.freeze storylet
        return this # Allow Chaining
      resolve: (q) ->
        if q instanceof Storylet
          q
        else
          library[q.toString()]
      filterVisible: (qualities) ->
        storylet for _, storylet of library when storylet.isVisibleWith(qualities)
    return Object.freeze api
