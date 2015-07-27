angular.module 'gameDefinition', [
  'qbn.edsl'
  'qbn.quality'
  'gameDefinition.enums'
  'gameDefinition.qualities'
  'gameDefinition.frontChoices'
  'gameDefinition.introStories'
  'gameDefinition.clientStories'
  'gameDefinition.jackieStories'
]
  .run (qbnEdsl, enums, qualities) ->
    {storylet, start, choice, front, retreat, onwards, reqs, consq} = qbnEdsl
    {leads, origins} = enums

    retreat choice 'retreat',
      'On second thought, maybe not…'
      '_Return to the main screen._'
      next: false

    onwards choice 'onwards',
      'The story continues…'
      '_Return to the main screen._'
      next: false

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
            jackie: reqs.gte 1
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
            rumor: reqs.gte 10
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
          everything the police know about anything.
          '''
          active:
            bluebacks: reqs.gte 10
            keyOfDreams: reqs.exists
      ]

    return
