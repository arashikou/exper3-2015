class Quality
  constructor: (@name, @description, @defaultValue, @defaultProgress, @maxProgress) ->

angular.module 'qbn.quality', ['qbn.instantiator']
  .factory 'qualityLibrary', (instantiator) ->
    library = {}
    api =
      register: (id, name, options) ->
        quality = Object.freeze new Quality()
        library[id] = instantiator quality
        return this # Allow Chaining
      resolve: (q) ->
        if q instanceof Quality
          q
        else
          library[q.toString()]
    return Object.freeze(api)
