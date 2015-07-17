class Choice
  constructor: (@title, @text, @visibleReqs, @activeReqs, @next) ->
    Object.freeze @

  reqsAreMet = (reqs, qualityLibrary) ->
    for qualityName, predicate of reqs
      quality = qualityLibrary.resolve qualityName
      return false unless predicate quality
    return true

  isVisibleWith: (qualityLibrary) ->
    reqsAreMet @visibleReqs, qualityLibrary

  isActiveWith: (qualityLibrary) ->
    reqsAreMet @activeReqs, qualityLibrary

angular.module 'qbn.choice', ['qbn.quality']
  .factory 'frontFacingChoiceLibrary', (qualityLibrary) ->
    library = []
    api =
      register: (choice) ->
        library.push choice # Choices are stored in immutable form
        return this # Allow Chaining
      getAll: () ->
        library.filter (storylet) -> storylet.isVisibleWith qualityLibrary
    return Object.freeze api
  .factory 'choiceFactory', () ->
    (args...) -> new Choice args...
