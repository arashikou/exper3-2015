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
    {storylet, choice, front} = qbnEdsl

    storylet 'harrowing-carriage',
      'A Harrowing Carriage-Voyage'
      (qualities) ->
        desc = if qualities.lookup('punchiness').value > 5 then 'sexy beast' else 'blob'
        """
        Insert purple prose here, you #{desc}.
        """

    front choice 'harrowing-carriage',
      'A Harrowing Carriage-Voyage'
      'Well, this is unpleasant…'
      'harrowing-carriage'

    return
