angular.module 'gameDefinition', ['qbn.quality', 'qbn.storylet']
  .run (qualityLibrary) ->
    qualityLibrary
      .register 'punchiness', 'Punchiness', 'One\'s capability for punching.',
        defaultValue: 7
    return
