class Storylet
  constructor: (@title, @text, @choices) ->

angular.module 'qbn.storylet', []
  .factory 'storyletLibrary', () ->
    library = {}
    api =
      register: (id, title, text, options) ->
        storylet = new Storylet()
        library[id] = Object.freeze(storylet)
        return this # Allow Chaining
      resolve: (q) ->
        if q instanceof Storylet
          q
        else
          library[q.toString()]
    return Object.freeze(api)
