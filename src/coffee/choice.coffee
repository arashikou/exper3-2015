angular.module 'qbn.choice', ['qbn.quality']
  .factory 'frontalChoices', () ->
    library = []
    retreat = undefined
    onwards = undefined
    api =
      register: (choice) ->
        library.push choice # Choices are stored in immutable form
        return @ # Allow Chaining
      setRetreat: (choice) ->
        retreat = choice
        return @
      getRetreat: () -> retreat
      setOnwards: (choice) ->
        onwards = choice
        return @
      getOnwards: () -> onwards
      getAll: () ->
        library.filter (choice) -> choice.isVisible()
    return Object.freeze api
  .factory 'choiceFactory', (qualities) ->
    validateReqs = (reqs) ->
      validations =
        for qualityName, chattyPredicate of reqs
          quality = qualities.lookup qualityName
          chattyPredicate quality
      validations.filter (v) -> v != true

    class Choice
      constructor: (@id, @title, @text, @visibleReqs, @activeReqs, @next) ->
        Object.freeze @

      isVisible: () -> (validateReqs @visibleReqs).length == 0

      isActive: () -> @unsatisfiedActiveReqs().length == 0

      unsatisfiedActiveReqs: () -> validateReqs @activeReqs

    (args...) -> new Choice args...
