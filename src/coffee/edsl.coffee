angular.module 'qbn.edsl', ['qbn.quality', 'qbn.storylet', 'qbn.choice']
  .factory 'qbnEdsl', (qualities, storylets, frontalChoices, choiceFactory) ->
    api =
      quality: (id, name, description, args = {}) ->
        {value, progress, maxProgress, hasProgress, progressEscalation,
         visible} = args
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
        {visibleReqs, activeReqs} = args
        visibleReqs ?= {}
        activeReqs ?= {}
        choiceFactory id, title, text, visibleReqs, activeReqs, next
      front: (choice) ->
        frontalChoices.register choice
        return
    return Object.freeze api
