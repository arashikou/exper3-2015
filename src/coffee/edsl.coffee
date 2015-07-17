angular.module 'qbn.edsl', ['qbn.quality', 'qbn.storylet']
  .factory 'qbnEdsl', (qualityLibrary, storyletLibrary, choiceFactory) ->
    api =
      quality: (id, name, description, args = {}) ->
        {defaultValue, defaultProgress, maxProgress, hasProgress, progressEscalation,
         visible} = args
        defaultValue ?= 0
        defaultProgress ?= 0
        maxProgress ?= if hasProgress then 100 else 0
        progressEscalation ?= 0.10
        visible ?= true
        qualityLibrary.register id, name, description, defaultValue,
                                defaultProgress, maxProgress, progressEscalation,
                                visible
        return
      storylet: (id, title, text, choices = [], args = {}) ->
        {frontFacingChoice} = args
        storyletLibrary.register id, title, text, choices, frontFacingChoice
        return
      choice: (title, text, next, args) ->
        {visibleReqs, activeReqs} = args
        visibleReqs ?= {}
        activeReqs ?= {}
        choiceFactory title, text, visibleReqs, activeReqs, args
    return Object.freeze api
