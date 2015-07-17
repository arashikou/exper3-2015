class Storylet
  constructor: (@id, @title, @text, @choices) ->
    Object.freeze @

angular.module 'qbn.storylet', []
  .factory 'storylets', () ->
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
    return Object.freeze api
