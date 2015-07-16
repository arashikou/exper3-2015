class Quality
  constructor: (@name, @description, @defaultValue, @defaultProgress, @maxProgress) ->

angular.module 'qbn.quality', []
  .factory 'qualityLibrary', () ->
    library = {}
    api =
      register: (id, name, options) ->
        quality = new Quality()
        library[id] = Object.freeze(quality)
        return this # Allow Chaining
      resolve: (q) ->
        if q instanceof Quality
          q
        else
          library[q.toString()]
    return Object.freeze(api)
