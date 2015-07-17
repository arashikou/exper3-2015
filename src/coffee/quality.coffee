edsl = (id, name, description, args = {}) ->
  {defaultValue, defaultProgress, maxProgress, hasProgress, progressEscalation, visible} = args
  defaultValue ?= 0
  defaultProgress ?= 0
  maxProgress ?= if hasProgress then 100 else 0
  progressEscalation ?= 0.10
  visible ?= true
  new Quality(id, name, description, defaultValue,
              defaultProgress, maxProgress, progressEscalation,
              visible)

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
        quality = edsl args...
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
