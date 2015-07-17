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
    {storylet, choice, frontFacing} = qbnEdsl

    storylet 'harrowing-carriage', 'A Harrowing Carriage-Voyage',
      '''
      Insert purple prose here.
      '''

    frontFacing choice 'A Harrowing Carriage-Voyage',
      'Well, this is unpleasant…',
      'harrowing-carriage'

    return
