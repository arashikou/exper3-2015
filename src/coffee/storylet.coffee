angular.module 'qbn.storylet', ['qbn.state', 'qbn.quality']
  .factory 'storylets', (makeGameState, qualities) ->
    class Storylet
      constructor: (@id, @title, @text, @defaultChoices, @consequences) ->
        Object.freeze @

      performConsequences: () ->
          @consequenceReports =
            for qualityName, performer of @consequences
              quality = qualities.lookup qualityName
              performer quality

    library = {}
    api =
      register: (args...) ->
        storylet = new Storylet args...
        library[storylet.id] = storylet # Storylets are stored in immutable form
        return this # Allow Chaining
      lookup: (q) ->
        if q instanceof Storylet
          q
        else
          storylet = library[q?.toString()]
          if storylet? then makeGameState storylet else undefined
    return Object.freeze api
