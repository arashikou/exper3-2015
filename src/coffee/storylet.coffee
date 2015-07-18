class Storylet
  constructor: (@id, @title, @text, @choices) ->
    Object.freeze @

angular.module 'qbn.storylet', ['qbn.state']
  .factory 'storylets', (makeGameState) ->
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
          makeGameState library[q.toString()]
    return Object.freeze api
