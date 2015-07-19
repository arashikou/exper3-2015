class Quality
  constructor: (@id, @name, @format, @description, @defaultValue,
                @defaultProgress, @defaultMaxProgress, @progressEscalation,
                @visible) ->
    Object.freeze @

  increase: (whole, partial) ->
    up = 1
    down = -1
    level = (direction) =>
      @value += direction
      @maxProgress =
        if direction == up
          @maxProgress * (1 + @progressEscalation)
        else
          @maxProgress / (1 + @progressEscalation)
      return

    level(if whole >= 0 then up else down) for [0...whole]

    @progress += partial
    while @progress > @maxProgress
      @progress -= @maxProgress
      level(up)
    while @progress < 0
      level(down)
      @progress += @maxProgress

    return

angular.module 'qbn.quality', ['qbn.state']
  .factory 'qualities', (makeGameState) ->
    library = {}
    api =
      register: (args...) ->
        quality = new Quality args...
        library[quality.id] = makeGameState quality # Qualities are stored in state form.
        return this # Allow Chaining
      lookup: (q) ->
        if q instanceof Quality
          q
        else
          library[q?.toString()]
      getAll: () ->
        quality for _, quality of library when quality.visible && quality.value
    return Object.freeze api
