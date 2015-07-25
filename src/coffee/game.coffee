origins =
  illusionist: 'an illusionist'
  hallucinist: 'a hallucinist'
  hypnotist: 'a hypnotist'

angular.module 'gameDefinition', ['qbn.edsl', 'qbn.quality']
  .run (qbnEdsl) ->
    {quality, qualityType} = qbnEdsl

    quality 'day',
      () -> "Day #{@value} of the Investigation"
      'Day'
      undefined
      value: 1

    quality 'bother',
      () -> "You have already bothered your client today"
      'Bother'
      'If you want to trouble her again, you\'ll have to try tomorrow.'

    quality 'illusionHunch', qualityType.item,
      'Illusion Hunch'
      '''
      Used to see the true form of things.
      '''
      value: 1

    quality 'hallucinationHunch', qualityType.item,
      'Hallucination Hunch'
      '''
      Used to spot nonexistant things.
      '''
      value: 1

    quality 'hypnotismHunch', qualityType.item,
      'Hypnotism Hunch'
      '''
      Used to notice when others are being controlled.
      '''
      value: 1

    quality 'bluebacks', qualityType.item,
      'Bluebacks'
      'Magical counterfeit-proof bills. They\'re actually more of an iridescent black.'

    quality 'cantripUp', qualityType.item,
      'Cantrip-Up'
      'The beverage of mages. Contains concentrated warpweft that mildly enhances magical powers.'
      value: 1

    quality 'rumor', qualityType.item,
      'Rumor'
      'Good, old-fashioned gossip. Juicy secrets that lose their value once spread.'

    quality 'cagedDemon', qualityType.item,
      'Caged Demon'
      'Demonology is illegal, but harvesting these from old battlefields is a public service.'

    quality 'origin',
      () -> "You were #{@value}"
      'Origin'
      (origin) ->
        switch origin
          when origins.illusionist
            'Gives you 1 more Illusion Hunch each day.'
          when origins.hallucinist
            'Gives you 1 more Hallucination Hunch each day.'
          when origins.hypnotist
            'Gives you 1 more Hypnotism Hunch each day.'

    return

  .run (qbnEdsl, qualities) ->
    {storylet, start, choice, front, retreat, onwards, reqs, consq} = qbnEdsl

    retreat choice 'retreat',
      'On second thought, maybe not…'
      '_Return to the previous screen._'

    onwards choice 'onwards',
      'The story continues…'

    ## Intro
    start 'lets-begin'

    storylet 'lets-begin',
      'It was a dark and stormy decade…'
      '''
      The years that followed the commoditization of sorcery were tumultous and difficult. People
      were faced with an ever-expanding array of new possibilities for their lives. The social
      order was shaken like an uptown Old Fashioned.

      There was, naturally, a war. You came out of it with a few interesting scars to share with
      those most intimate and one very uninteresting scar on your psyche that left you permanently
      unable to access the sorceric warpweave ever again. It was a shame, too. You'd had such a
      promising career before that, studying…

      Which branch of magic was it again?
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
      Yes, that was it.

      Anyway, that's all over now. The war left you without a scrap of magic
      to your name, just a strange itch whenever you're in the presence of your old field of work.

      But you, you were enterprising. You parleyed that subliminal itch, that instinct about magic,
      into a career as a detective. When people have problems that seem magical in nature, they come
      to you. You are The Disillusionist.
      '''
    beginChoice =
      choice 'begin-case',
        'Tell me about my latest case'

    storylet 'begin-illusion',
      'Ah, Illusion'
      beginSnippet
      consequences:
        origin: consq.set origins.illusionist
        illusionHunch: consq.increase 1
      choices: [beginChoice]

    storylet 'begin-hallucination',
      'Ah, Hallucination'
      beginSnippet
      consequences:
        origin: consq.set origins.hallucinist
        hallucinationHunch: consq.increase 1
      choices: [beginChoice]

    storylet 'begin-hypnotism',
      'Ah, Hypnotism'
      beginSnippet
      consequences:
        origin: consq.set origins.hypnotist
        hypnotismHunch: consq.increase 1
      choices: [beginChoice]

    storylet 'begin-case',
      'It was late on a Tuesday…'
      '''
      It was late on a Tuesday when Mrs. Abigail Brown walked into your office. Normally, when a
      lady that well-dressed sees fit to cross your door, there's infidelity behind it. It means
      long nights staking out a love nest in your future, waiting for Mr. Client to come dally with
      Not-Mrs. Client.

      But something was off. This wasn't the usual cheating-husband job. There was a tear to her
      eye before she even
      got in your door, not the mixture of determination and shame that eventually gave way to
      either sobbing or rage.

      Over the next forty-five minutes, you drew the whole story out of her. How she was the wife
      of famed sorcerer Horace Brown. How he had gone missing two weeks ago from a sealed parlor
      in their Silver Street home. How the police had dismissed the case with suspicious ease,
      insisting Mr.
      Brown must have simply had an accident with forces beyond his control. As if "Demon Eyes
      Brown" had ever met a force he could not match.

      You took the case in a heartbeat. This was not only the most interesting case to cross your
      desk since there was snow on the ground, but it stood to be the most lucrative in a long time,
      and the landlord was starting to resemble a hungry wolf more and more each day. Mrs. Brown
      paid the retainer for your first two days and didn't even haggle the rate.

      Now the only question was: Where to start looking?
      '''
      consequences:
        bluebacks: consq.increase 2

    ## Front Categories
    front choice 'botherClient',
      'Visit the client'
      '''
      Is there something you need from Mrs. Brown? Or are you just hoping to inspect the scene of
      the crime?
      '''
      active:
        bother: (quality) -> if not quality.value then true else
          'You have already bothered Mrs. Brown today. Try again tomorrow.'

    front choice 'straightTrades',
      'Do odd jobs'
      '''
      Sure, you're working for Mrs. Brown, but doing that takes resources. Resources you'll have
      to earn some other way.
      '''

    front choice 'storylines',
      'Track down a lead'
      '''
      You know a few places to start looking for info.
      '''

    front choice 'rest',
      'Return home to rest'
      '''
      It's been a long day. Perhaps it's time to go back to your apartment and get some shuteye.

      _This will advance the day by one and regenerate you to full hunches._
      '''

    ## Rest

    storylet 'rest',
      'Return home to rest'
      '''
      It's been a long day. Perhaps it's time to go back to your apartment and get some shuteye.
      '''
      choices: [
        choice 'endOfDay',
          (day) -> "End day #{day} of the investigation"
          '_This will advance the day by one and regenerate you to full hunches._'
      ]

    storylet 'endOfDay',
      'You sleep the sleep of the employed-per-diem-plus-expenses'
      undefined
      consequences:
        illusionHunch: (quality) ->
          hunches = 1
          hunches++ if qualities.lookup('origin').value == origins.illusionist
          quality.value = hunches
          "You now have #{hunches} Illusion Hunches."
        hallucinationHunch: (quality) ->
          hunches = 1
          hunches++ if qualities.lookup('origin').value == origins.hallucinist
          quality.value = hunches
          "You now have #{hunches} Hallucination Hunches."
        hypnotismHunch: (quality) ->
          hunches = 1
          hunches++ if qualities.lookup('origin').value == origins.hypnotist
          quality.value = hunches
          "You now have #{hunches} Hypnotism Hunches."
        bother: (quality) ->
          if quality.value
            quality.value = false
            'It\'s a new day, and your client is again willing to see you.'
        day: consq.increase 1

    ## Straight Trades
    storylet 'straightTrades',
      'Odd jobs'
      '''
      There's always work to be had for someone with your particular talents. It's not always
      _good_ work, but it pays.

      Of course, it takes money to make money. Or in your case, it takes hunches. If you're all
      tapped out, you may just have to come back tomorrow.
      '''
      choices: [
        choice 'warehouseStraight',
          'Find warehouse cover-ups'
          'Search warehouses for faked shipments.'
          active:
            illusionHunch: reqs.gt 0
        choice 'partyStraight',
          'Clean up after a party'
          'The students from the Department of Illusory Arts don\'t just throw regular parties.'
          active:
            illusionHunch: reqs.gt 0
        choice 'antiqueStraight',
          'Filter an antiquarian\'s collection'
          'Unscrupulous types often sell fake antiques to unsuspecting shops.'
          active:
            hallucinationHunch: reqs.gt 0
        choice 'beatWalkStraight',
          'Search for public menaces'
          'Walk a police beat looking for hallucinatory graffiti.'
          active:
            hallucinationHunch: reqs.gt 0
        choice 'dealsStraight',
          'Notarize business deals'
          'It\'s important to make sure no one signing a contract is under an enchantment.'
          active:
            hallucinationHunch: reqs.gt 0
        choice 'securityStraight',
          'Provide building security'
          'Check each employee before they enter to make sure they haven\'t been compromised.'
          active:
            hallucinationHunch: reqs.gt 0
      ]

    storylet 'warehouseStraight',
      'Find warehouse cover-ups'
      '''
      You spend a few hours pointing out crates that have been magically modified and bills of
      lading that have been magically forged. The foreman can't afford to pay you, but you wave
      him off. You got more than your money's worth in gossip from the dockworkers.
      '''
      consequences:
        illusionHunch: consq.decrease 1
        rumor: consq.increase 2

    storylet 'partyStraight',
      'Clean up after a party'
      '''
      Along with moving furniture, you helpfully point out which objects have been carelessly
      transmuted or obscured. With any luck, the landlord will never realize how much this place
      resembled a magical strip club in a junk heap this morning. Being poor students, they can only
      pay in leftovers from last night, but it's worth the effort.
      '''
      consequences:
        illusionHunch: consq.decrease 1
        cantripUp: consq.increase 2

    storylet 'antiqueStraight',
      'Filter an antiquarian\'s collection'
      '''
      You gently break the news. This one is fake. That one is real. The large one in the back? It
      never existed at all. The antiquarian, forseeing lean times in his future, can only offer a
      "mage's wages."
      '''
      consequences:
        hallucinationHunch: consq.decrease 1
        cantripUp: consq.increase 2

    storylet 'beatWalkStraight',
      'Search for public menaces'
      '''
      You find the work of a few overnight vandals, including some really impressive choreographed
      dragons and flamingos in the theater district. Maybe someone was trying to audition to do
      special effects?

      The police pay you duly for your help.
      '''
      consequences:
        hallucinationHunch: consq.decrease 1
        bluebacks: consq.increase 2

    storylet 'dealsStraight',
      'Notarize business deals'
      '''
      It's the dryest possible work, just sitting there watching all parties in a negotiation
      to make sure there's no funny business going on. There isn't, of course, but the reassurance
      of your presence is essential. And you pick up plentiful info from the deals you overhear.
      '''
      consequences:
        hypnotismHunch: consq.decrease 1
        rumor: consq.increase 2

    storylet 'securityStraight',
      'Provide building security'
      '''
      Most people pass muster, but you do have to stop a few for additional investigation. One
      appears to be genuinely unaware of her predicament and is sent off for disenchanting. Another
      is apparently into some very unorthodox uses of spellwork in the bedroom and
      forgot to clean everything off himself afterwards. He is likewise sent off for disenchanting.
      …and a bath.
      '''
      consequences:
        hypnotismHunch: consq.decrease 1
        bluebacks: consq.increase 2

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
