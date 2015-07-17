class Quality
  constructor: (@id, @name, @description, @defaultValue,
                @defaultProgress, @maxProgress, @progressEscalation,
                @visible) ->
    Object.freeze @

  increase: (whole, partial = 0) ->
    levelUp = () =>
      @value++
      @maxProgress += @maxProgress * @progressEscalation
      return

    levelUp() for [1..whole]

    @progress += partial
    while @progress > @maxProgress
      @progress -= @maxProgress
      levelUp()

    return

angular.module 'qbn.quality', ['qbn.state']
  .factory 'qualityLibrary', (makeGameState) ->
    library = {}
    api =
      register: (args...) ->
        quality = new Quality args...
        library[quality.id] = makeGameState quality # Qualities are stored in state form.
        return this # Allow Chaining
      resolve: (q) ->
        if q instanceof Quality
          q
        else
          library[q.toString()]
      getAll: () ->
        quality for _, quality of library when quality.visible
    return Object.freeze api
