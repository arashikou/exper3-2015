angular.module 'gameDefinition.qualities', ['qbn.edsl', 'gameDefinition.enums']
  .run (qbnEdsl, enums) ->
    {quality, qualityType} = qbnEdsl
    {origins, leads} = enums

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

    quality 'lead',
      () -> "Current Lead: #{@value}"
      'Your current lead'
      undefined
      value: leads.none

    quality 'progress',
      () -> "Lead Progress: #{@value}"
      'Your progress on your lead'
      undefined
      value: 0

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

    quality 'jackie',
      () ->
        switch @value
          when 1 then 'Mr. Brown hired a private eye before his disappearance'
          when 2 then 'Jackie has asked you to find his partner'
          when 3 then 'You found Jackie\'s partner for him'
          when 4 then 'You found Jackie\'s partner but decided to keep it quiet'
      '!!ERROR!!', undefined

    quality 'kbs',
      () ->
        switch @value
          when 1 then 'You are headhunting for KB&S'
          when 2 then 'You found an ecclectic crew for KB&S'
      '!!ERROR!!', undefined

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

    quality 'inscribedRibbon', qualityType.item,
      'Inscribed Ribbon'
      'Gives you 1 more Illusion Hunch each day.'

    quality 'sealboneTrinket', qualityType.item,
      'Sealbone Trinket'
      'Gives you 1 more Hallucination Hunch each day.'

    quality 'veinyCarnelian', qualityType.item,
      'Veiny Carnelian'
      'Gives you 1 more Hypnotism Hunch each day.'

    return
