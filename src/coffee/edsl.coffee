angular.module 'qbn.edsl', ['qbn.quality', 'qbn.storylet', 'qbn.choice']
  .factory 'qbnEdsl', (qualities, storylets, frontalChoices, choiceFactory) ->
    api =
      quality: (id, name, description, args = {}) ->
        {value, progress, maxProgress, hasProgress, progressEscalation, visible} = args
        value ?= 0
        progress ?= 0
        maxProgress ?= if hasProgress then 100 else 0
        progressEscalation ?= 0.10
        visible ?= true
        qualities.register id, name, description, value,
                           progress, maxProgress, progressEscalation,
                           visible
        return
      storylet: (id, title, text, choices...) ->
        storylets.register id, title, text, choices
        return
      choice: (id, title, text, next, args = {}) ->
        {visible, active} = args
        visible ?= {}
        active ?= {}
        choiceFactory id, title, text, visible, active, next
      front: (choice) ->
        frontalChoices.register choice
        return
      increase: (qualityName, major, minor) ->
        quality = qualities.lookup(qualityName)
        if quality?
          hasProgress = quality.maxProgress != 0
          if hasProgress
            quality.increase(minor, major)
          else
            quality.increase(major, 0)
        return
    return Object.freeze api
