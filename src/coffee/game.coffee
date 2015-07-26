origins =
  illusionist: 'an illusionist'
  hallucinist: 'a hallucinist'
  hypnotist: 'a hypnotist'

angular.module 'gameDefinition', ['qbn.edsl', 'qbn.quality']
  .run (qbnEdsl) ->
    {quality, qualityType} = qbnEdsl

    quality 'keyOfDreams', qualityType.item,
      'Key of Dreams' # Shamelessly stealing this name from Storynexus
      'An item that does not exist yet is necessary to access unimplemented content.'
      value: 0

    ## Primary Stats

    quality 'day',
      () -> "Day #{@value} of the Investigation"
      'Day'
      undefined
      value: 1

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

    quality 'evidence', qualityType.item,
      'Evidence'
      'Gather enough of this to solve the case!'

    ## Primary Resources

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

    ## Secondary Resources

    quality 'cagedDemon', qualityType.item,
      'Caged Demon'
      'Demonology is illegal, but harvesting these from old battlefields is a public service.'

    ## Special Items

    quality 'jackieReceipt', qualityType.item,
      'Receipt from Jackie'
      'Proof that Mr. Brown hired a private detective before his death.'

    quality 'roxyThugDescription', qualityType.item,
      'Description of Roxy\'s Thugs'
      'Roxy wants Mrs. Brown out of town.'

    ## Incidental Deatails

    quality 'bother',
      () -> "You have already bothered your client today"
      'Bother'

    quality 'advance',
      () -> "You have gotten an advance on your payment"
      'Advance'

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

    retreatChoice = choice 'retreat',
      'On second thought, maybe not…'
      '_Return to the main screen._'
    retreat retreatChoice

    onwards choice 'onwards',
      'The story continues…'
      '_Return to the main screen._'

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

      _This will advance the day by one and reset your hunches._
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
          '_This will advance the day by one and reset your hunches._'
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
            illusionHunch: reqs.gte 1
        choice 'partyStraight',
          'Clean up after a party'
          'The students from the Department of Illusory Arts don\'t just throw regular parties.'
          active:
            illusionHunch: reqs.gte 1
        choice 'antiqueStraight',
          'Filter an antiquarian\'s collection'
          'Unscrupulous types often sell fake antiques to unsuspecting shops.'
          active:
            hallucinationHunch: reqs.gte 1
        choice 'beatWalkStraight',
          'Search for public menaces'
          'Walk a police beat looking for hallucinatory graffiti.'
          active:
            hallucinationHunch: reqs.gte 1
        choice 'dealsStraight',
          'Notarize business deals'
          'It\'s important to make sure no one signing a contract is under an enchantment.'
          active:
            hypnotismHunch: reqs.gte 1
        choice 'securityStraight',
          'Provide building security'
          'Check each employee before they enter to make sure they haven\'t been compromised.'
          active:
            hypnotismHunch: reqs.gte 1
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

    ## The Client
    storylet 'botherClient',
      'Visit the client'
      '''
      Mrs. Brown is at home when you arrive. A servant offers to fetch her. Are you here to see her
      or to investigate the crime scene?
      '''
      choices: [
        choice 'solveEvidence',
          'Solve the case with evidence'
          '''
          But if this… Then that… Which means…
          '''
          active:
            evidence: reqs.gte 10
            keyOfDreams: reqs.exists
        choice 'solveHunch',
          'Solve the case with pure gumption'
          '''
          Something about this situation doesn't seem right. Damn collecting evidence; with enough
          hunches, you could blow this case wide open!
          '''
          active:
            illusionHunch: reqs.gte 3
            hallucinationHunch: reqs.gte 3
            hypnotismHunch: reqs.gte 3
            keyOfDreams: reqs.exists
        choice 'advanceAsk',
          'Ask for an advance'
          '''
          This case is taking a while, and the retainer's running thin. It's time to hit up the
          client for more money.
          '''
          visible:
            day: reqs.gte 3
            advance: reqs.notexists
        choice 'askClient1',
          'Ask for more info'
          '''
          You feel like maybe there's something she hasn't told you yet.
          '''
          visible:
            jackieReceipt: reqs.lte 0
        choice 'askClient2',
          'Ask what\'s wrong'
          '''
          When you arrive, the sound of Mrs. Brown's sobbing fills the house. Something is
          definitely up.
          '''
          visible:
            day: reqs.gte 5
            roxyThugDescription: reqs.lte 0
        choice 'crimeScene',
          'Inspect the crime scene'
          'There are bound to be clues the police\'s half-hearted investigation missed.'
      ]

    # TODO: storylet 'solveEvidence'

    # TODO: storylet 'solveHunch'

    setBothered = (bothered) ->
      bothered.value = true
      'Mrs. Brown does not wish to see you again today.'

    storylet 'advanceAsk',
      'Ask for an advance'
      '''
      Mrs. Brown is a little less free with her funds this time. Perhaps she expected the case to
      be resolved by now, in which case she's a fool. Or perhaps she showed the contract to one of
      her accountants, in which case she's less-so. Nonetheless, you are able to draw a little blood
      from the stone before being sent on your way with a reminder to earn that money.
      '''
      consequences:
        bluebacks: consq.increase 6
        bother: setBothered
        advance: (quality) ->
          quality.value = true
          'You will not be able to ask for an advance again.'

    storylet 'askClient1',
      'Ask for more info'
      '''
      "Actually, there is something new," she purrs. "While I was going through Horry's old things,
      I came across this receipt."

      She hands you a receipt almost identical to the one you made out for her in your office.

      "It seems I wasn't the first one to employ a private detective. Though what he hired this
      'Jackie' for, I couldn't say."

      You know Jackie. He's one of the old guard. He was in this business before the war, before
      magic. Hell, maybe before you were even born. The new world hasn't been kind to him, though,
      and word is he fell on hard times recently. Maybe hard enough to get him to parley with the
      competition? It's not much, but it's a start.
      '''
      consequences:
        jackieReceipt: consq.increase 1
        bother: setBothered

    storylet 'askClient2',
      'Ask what\'s wrong'
      '''
      "Oh, it's horrible! You just missed them! Two thugs were here, making threats! Warning
      me to stop the investigation! Telling me to leave town!"

      After you calm Mrs. Brown down, you get a description of the thugs. The purple carnation
      lapel pins make them
      easy to identify. These boys belonged to Roxy Malone, one of the three biggest gangsters in
      the city. What Roxy's stake in this is, you have no idea, but you aim to ask her.

      You make a point of not asking if Mrs. Brown wants the investigation called off, and she
      doesn't make a point of telling you. This one is too juicy to let slip away.
      '''
      consequences:
        roxyThugDescription: consq.increase 1
        bother: setBothered

    storylet 'crimeScene',
      'Inspect the crime scene'
      '''
      Mrs. Brown has a servant let you into the witching parlor. She can't bear to look at it
      herself. What are you looking for?
      '''
      choices: [
        choice 'crimeSceneIllusion',
          'Evidence of illusions'
        choice 'crimeSceneHallucination',
          'Evidence of hallucinations'
        choice 'crimeSceneHypnotism',
          'Evidence of hypnotisms'
        choice 'crimeSceneRumor',
          'Information in Horace Brown\'s files'
        choice 'crimeSceneDrink',
          'Actually, I\'m here to raid the liquor cabinet'
        retreatChoice
      ]

    storylet 'crimeSceneIllusion',
      'Evidence of illusions'
      '''
      Someone on the house staff has been using illusions to hide subpar housework. It's amateur
      stuff, but it confounds your search. Nonetheless, there has definitely been a more
      competent illusionist
      at work here as well. But was it Brown or someone else?
      '''
      consequences:
        illusionHunch: consq.increase 1
        bother: setBothered

    storylet 'crimeSceneHallucination',
      'Evidence of hallucinations'
      '''
      If there were any hallucinations here, they've been cleaned up. But sometimes a hallucination
      is telling by its absence. There are three suspicious gaps in the decor on the wall opposite
      the windows. By the looks of it, there were hallucinations here for quite some time; the
      staff had been cleaning around them. Were they Brown's work? Or somehow related to his
      disappearance?
      '''
      consequences:
        hallucinationHunch: consq.increase 1
        bother: setBothered

    storylet 'crimeSceneHypnotism',
      'Evidence of hypnotisms'
      '''
      Your brain is on fire. Here, by the workbench. Judging by the height, the person was in the
      process of standing up. And over here, by the window. But this one, it was a different person
      than the first…
      '''
      consequences:
        hypnotismHunch: consq.increase 1
        bother: setBothered

    storylet 'crimeSceneRumor',
      'Information in Horace Brown\'s files'
      '''
      You don't turn up any evidence relevant to the case, but you do turn up some juicy tidbits
      that you're pretty sure aren't public knowledge.
      '''
      consequences:
        rumor: consq.increase 3
        bother: setBothered

    storylet 'crimeSceneDrink',
      'Raiding the liquor cabinet'
      '''
      Alas, the liquor has been removed, perhaps against just such an eventuality. But you are
      able to snag a few Cantrip-Ups that you don't imagine will be missed.
      '''
      consequences:
        cantripUp: consq.increase 3
        bother: setBothered

    ## Leads

    storylet 'storylines',
      'Track down a lead'
      '''
      You sit down at your desk and pool all your possible leads. Someone out there has to
      know something about what happened. The question is: Who?

      _If you successfully start a lead, you will be committed to that lead and unable to follow up
      any others until you see your current lead through._
      '''
      choices: [
        choice 'jackieStart',
          'Jackie, old-school detective'
          'Mr. Brown hired Jackie to do something. What? And why?'
          visible:
            jackieReceipt: reqs.gte 1
          active:
            keyOfDreams: reqs.exists
        choice 'roxyStart',
          'Roxy Malone, big-time gangster'
          'Roxy is trying to intimidate Mrs. Brown. But why?'
          visible:
            roxyThugDescription: reqs.gte 1
          active:
            keyOfDreams: reqs.exists
        choice 'businessStart',
          'Mr. Brown\'s last employer'
          '''
          Mr. Brown was doing work for hire for the offices of Kimble, Battherwhite, and Smith when
          he disappeared.
          Someone there might know something.
          '''
          active:
            keyOfDreams: reqs.exists
        choice 'clubEntry',
          'The Salamander Club'
          '''
          Ever since you lost your magical abilities, you've lost touch with the magical community
          in the city.
          The Salamander Club is a favorite watering hole of the sorcerous set and your best bet to
          make contact with anyone who might know Mr. Brown.
          '''
          active:
            cantripUp: reqs.gte 6
            keyOfDreams: reqs.exists
        choice 'pressStart',
          'The press'
          '''
          The disappearance of someone as high-profile as Horace Brown should be all over the news.
          But Mrs. Brown was the first you heard of it. Who is keeping the bloggers quiet? Maybe one
          of your contacts knows.
          '''
          active:
            keyOfDreams: reqs.exists
        choice 'copStart',
          'A crooked cop'
          '''
          Officer Dentley is a lousy cop, but a great informant. For the right fee, he'll tell you
          everything the police know.
          '''
          active:
            keyOfDreams: reqs.exists
      ]

    return
