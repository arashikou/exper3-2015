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
      'After this, there will be no stopping the Khanduke.'
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
      'It was a dark and stormy decade…'
      '''
      The years that followed the commoditization of sorcery were tumultous and difficult. People
      were faced with an ever-expanding array of new possibilities for their lives. The social
      order was shaken like an uptown Old Fashioned. There was, naturally, a war. You came out of it
      with a few interesting scars to share with lovers and one very uninteresting scar on your
      psyche that left you permanently unable to access the sorceric warpweave ever again. It was a
      shame, too. You'd had such a promising career before that, studying… Which branch of magic was
      it again?
      '''
      choices: [
        choice 'begin-illusion',
          'Illusion'
          'The magic of making one thing appear to be another thing.'
        choice 'begin-hallucination',
          'Hallucination'
          'The magic of making things appear to exist which do not.'
        choice 'begin-hypnotism',
          'Hypnotism'
          'The magic of making people believe things they do not.'
      ]

    beginSnippet =
      '''
      Ah, yes, that was it. Anyway, that's all over now. The war left you without a scrap of magic
      to your name, just a strange itch whenever you were in the presence of your old field of work.
      But you, you were enterprising. You parleyed that subliminal itch, that instinct about magic,
      into a career as a detective. When people have problems that seem magical in nature, they come
      to you. You are The Disillusionist.
      '''
    beginChoice =
      choice 'begin-case'

    storylet 'begin-illusion',
      'Ah, Illusion'
      '''
      The acrid smell of spellcraft was in the air, something you rarely enoucntered outside your
      own home.
      '''

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
