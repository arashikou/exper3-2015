angular.module 'qbn.choice', ['qbn.resolve']
  .factory 'frontalChoices', () ->
    library = []
    api =
      register: (choice) ->
        library.push choice # Choices are stored in immutable form
        return this # Allow Chaining
      getAll: () ->
        library.filter (choice) -> choice.isVisible()
    return Object.freeze api
  .factory 'choiceFactory', (resolveFilter) ->
    class Choice
      constructor: (@id, @title, @text, @visibleReqs, @activeReqs, @next) ->
        Object.freeze @

      isVisible: () -> resolveFilter @visibleReqs

      isActive: () -> resolveFilter @activeReqs

    (args...) -> new Choice args...
