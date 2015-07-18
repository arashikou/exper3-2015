class Choice
  constructor: (@id, @title, @text, @visibleReqs, @activeReqs, @next) ->
    Object.freeze @

  reqsAreMet = (reqs, qualities) ->
    for qualityName, predicate of reqs
      quality = qualities.lookup qualityName
      return false unless predicate quality
    return true

  isVisibleWith: (qualities) ->
    reqsAreMet @visibleReqs, qualities

  isActiveWith: (qualities) ->
    reqsAreMet @activeReqs, qualities

angular.module 'qbn.choice', ['qbn.quality']
  .factory 'frontalChoices', (qualities) ->
    library = []
    api =
      register: (choice) ->
        library.push choice # Choices are stored in immutable form
        return this # Allow Chaining
      getAll: () ->
        library.filter (storylet) -> storylet.isVisibleWith qualities
    return Object.freeze api
  .factory 'choiceFactory', () ->
    (args...) -> new Choice args...
