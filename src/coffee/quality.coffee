edsl = (id, name, description, args = {}) ->
  {defaultValue, defaultProgress, maxProgress, hasProgress} = args
  defaultValue ?= 0
  defaultProgress ?= 0
  maxProgress ?= if hasProgress then 100 else 0
  Object.freeze new Quality(id, name, description, defaultValue, defaultProgress, maxProgress)

class Quality
  constructor: (@id, @name, @description, @defaultValue, @defaultProgress, @maxProgress) ->

angular.module 'qbn.quality', ['qbn.state']
  .factory 'qualityLibrary', (makeGameState) ->
    library = {}
    api =
      register: (args...) ->
        quality = edsl args...
        library[quality.id] = makeGameState quality # Qualities are stored in state form.
        return this # Allow Chaining
      resolve: (q) ->
        if q instanceof Quality
          q
        else
          library[q.toString()]
      getAll: () ->
        quality for _, quality of library
    return Object.freeze api
