angular.module 'gameDefinition', ['qbn.edsl']
  .run (qbnEdsl) ->
    {quality, storylet, choice} = qbnEdsl

    quality 'punchiness', 'Punchiness', 'One\'s capability for punching.',
        defaultValue: 7

    quality 'luck', 'Luck', 'This text should never display.',
        defaultValue: -2
        visible: false

    return
