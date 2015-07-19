angular.module 'gameDefinition', ['qbn.edsl']
  .run (qbnEdsl) ->
    {quality} = qbnEdsl

    quality 'punchiness',
      'Punchiness'
      'One\'s capability for punching.'
      value: 2

    quality 'deathWish',
      'Death Wish'
      'Has existence become a burden?'
      value: false

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
      """
      You work out!
      """
      choice 'body-hard',
        'Hard!'
        'Let no muscle be spared!'
        'body-hard'
      choice 'body-soft',
        'Lightly'
        'I don\'t want to muss my moustache.'
        'body-soft'
      choice 'to-the-death',
        'To the death!',
        'Wait, actually, that sounds like a terrible idea.'
        'to-the-death'
        active: (deathWish) -> deathWish

    storylet 'body-hard',
      'You work out hard'
      () ->
        increase 'punchiness', 4
        'You ache, but it was worth it.'

    storylet 'body-soft',
      'You work out softly'
      () ->
        increase 'punchiness', 1
        'You don\'t even need to shower, but did it do anything?'

    front choice 'harrowing-carriage',
      'A Harrowing Carriage-Voyage'
      'Well, this is unpleasant…'
      'harrowing-carriage'

    storylet 'harrowing-carriage',
      'A Harrowing Carriage-Voyage'
      """
      This looks unsafe in a profound and painful way.
      """
      choice 'ride-carriage',
        'Do It'
        'And damn the consequences!'
        'ride-carriage'

    storylet 'ride-carriage',
      'A Harrowing Carriage-Voyage'
      (punchiness) ->
        desc = if punchiness > 5 then 'sexy beast' else 'blob'
        increase 'punchiness', -1
        """
        Insert purple prose here, you #{desc}.
        """

    return
