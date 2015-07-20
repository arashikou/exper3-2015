class Quality
  constructor: (@id, @name, @format, @description, @defaultValue,
                @defaultProgress, @defaultMaxProgress, @progressEscalation,
                @visible) ->
    Object.freeze @

  increase: (amount) ->
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

    if @maxProgress == 0
      level(if amount >= 0 then up else down) for [0...amount]
    else
      counter = 0
      @progress += amount
      while @progress > @maxProgress
        @progress -= @maxProgress
        level(up)
        counter++
      while @progress < 0
        level(down)
        @progress += @maxProgress
        counter++
      return counter

    return

  save: () ->
    id: @id
    value: @value
    progress: @progress
    maxProgress: @maxProgress

  load: (saved) ->
    @value = saved.value
    @progress = saved.progress
    @maxProgress = saved.maxProgress

angular.module 'qbn.quality', ['qbn.state']
  .factory 'qualities', (makeGameState) ->
    library = {}
    window.qualities = library # DEBUG ONLY
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
      saveAll: () ->
        quality.save() for _, quality of library
    return Object.freeze api
