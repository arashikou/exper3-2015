angular.module 'gameDefinition', ['qbn.quality', 'qbn.storylet']
  .run (qualityLibrary) ->
    qualityLibrary
      .register 'punchiness', 'Punchiness', 'One\'s capability for punching.',
        defaultValue: 7
      .register 'luck', 'Luck', 'This text should never display.',
        defaultValue: -2
        visible: false
    return
