angular.module 'gameDefinition', ['qbn.edsl']
  .run (qbnEdsl) ->
    {quality} = qbnEdsl

    quality 'punchiness',
      'Punchiness'
      'One\'s capability for punching.'
      value: 7

    quality 'luck',
      'Luck'
      'This text should never display.'
      value: -2
      visible: false

    return

  .run (qbnEdsl) ->
    {storylet, choice, front, increase} = qbnEdsl

    front choice 'body-building',
      'Bodybuilding Class'
      'Well, this is unpleasant…'
      'body-building'
      visible: (punchiness) -> punchiness <= 5

    storylet 'body-building',
      'Bodybuilding Class'
      () ->
        increase 'punchiness', 1
        """
        You work out!
        """

    front choice 'harrowing-carriage',
      'A Harrowing Carriage-Voyage'
      'Well, this is unpleasant…'
      'harrowing-carriage'

    storylet 'harrowing-carriage',
      'A Harrowing Carriage-Voyage'
      (punchiness) ->
        desc = if punchiness > 5 then 'sexy beast' else 'blob'
        increase 'punchiness', -1
        """
        Insert purple prose here, you #{desc}.
        """

    return
