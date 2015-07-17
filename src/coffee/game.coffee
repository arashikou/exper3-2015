angular.module 'gameDefinition', ['qbn.edsl']
  .run (qbnEdsl) ->
    {quality} = qbnEdsl

    quality 'punchiness', 'Punchiness', 'One\'s capability for punching.',
        defaultValue: 7

    quality 'luck', 'Luck', 'This text should never display.',
        defaultValue: -2
        visible: false

    return
  .run (qbnEdsl) ->
    {storylet, choice} = qbnEdsl

    storylet 'harrowing-carriage', 'A Harrowing Carriage-Voyage',
      '''
      Insert purple prose here.
      ''',
      [],
      frontFacingChoice: choice 'A Harrowing Carriage-Voyage', 'Well, this is unpleasant…'

    return
