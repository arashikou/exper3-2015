class Quality
  constructor: (@name, @description, @defaultValue, @defaultProgress, @maxProgress) ->

angular.module 'qbn.quality', ['qbn.state']
  .factory 'qualityLibrary', (makeGameState) ->
    library = {}
    api =
      register: (id, name, options) ->
        quality = Object.freeze new Quality()
        library[id] = makeGameState quality # Qualities are stored in state form
        return this # Allow Chaining
      resolve: (q) ->
        if q instanceof Quality
          q
        else
          library[q.toString()]
      getAll: () ->
        quality for quality of library
    return Object.freeze api
