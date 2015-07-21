locations =
  home:      "in the residential district"
  market:    "in the market"
  slums:     "in the slums"
  palace:    "in the royal palace"
  outskirts: "in the outskirts"

angular.module 'gameDefinition', ['qbn.edsl']
  .run (qbnEdsl) ->
    {quality, qualityType} = qbnEdsl

    quality 'hours', qualityType.item,
      'Hours Remaining'
      'After this, there will be no stopping the Duke.'
      value: 72

    quality 'stealth', qualityType.stat,
      'Stealth'
      'Hiding, Sneaking, Smuggling'
      value: 1

    quality 'sorcery', qualityType.stat,
      'Sorcery'
      'Casting, Blasting, Conjuring'
      value: 1

    quality 'strength', qualityType.stat,
      'Strength'
      'Action, Power, Combat'
      value: 1

    quality 'discovered', qualityType.unique,
      'Been Discovered'
      'That\'s not good.'
      value: false

    quality 'location', qualityType.string,
      '!!ERROR!!'
      undefined
      value: null

    return

  .run (qbnEdsl) ->
    {storylet, choice, front, retreat, onwards, reqs, consq} = qbnEdsl

    retreat choice 'retreat',
      'On second thought, maybe not…'
      'Return to the previous screen.'

    onwards choice 'onwards',
      'The story continues…'

    ## Intro

    front choice 'lets-begin',
      'Begin the Story'

    storylet 'lets-begin',
      'August 14th'
      '''

      '''
      choices: [
        choice 'lets-begin2'
          'OK, and then what?'
      ]

    return

    front choice 'body-building',
      'Bodybuilding Class'
      'Well, this is unpleasant…'
      visible:
        punchiness: reqs.lt 6

    storylet 'body-building',
      'Bodybuilding Class'
      """
      You work out!
      """
      choices: [
        choice 'body-hard',
          'Hard!'
          'Let no muscle be spared!'
        choice 'body-soft',
          'Lightly'
          'I don\'t want to muss my moustache.'
        choice 'to-the-death',
          'To the death!',
          'Wait, actually, that sounds like a terrible idea.'
          active:
            deathWish: reqs.exists
      ]

    storylet 'body-hard',
      'You work out hard'
      'You ache, but it was worth it.'
      consequences:
        punchiness: consq.increase 4

    storylet 'body-soft',
      'You work out softly'
      'You don\'t even need to shower, but did it do anything?'
      consequences:
        punchiness: consq.increase 1

    front choice 'harrowing-carriage',
      'A Harrowing Carriage-Voyage'
      'Well, this is unpleasant…'

    storylet 'harrowing-carriage',
      'A Harrowing Carriage-Voyage'
      """
      This looks unsafe in a profound and painful way.
      """
      choices: [
        choice 'ride-carriage',
          'Do It'
          'And damn the consequences!'
      ]

    storylet 'ride-carriage',
      'A Harrowing Carriage-Voyage'
      (punchiness) ->
        desc = if punchiness > 5 then 'sexy beast' else 'blob'
        """
        Insert purple prose here, you #{desc}.
        """
      consequences:
        punchiness: consq.decrease 1

    return
