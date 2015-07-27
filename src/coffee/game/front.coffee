angular.module 'gameDefinition.frontChoices', ['qbn.edsl', 'gameDefinition.enums']
  .run (qbnEdsl, enums) ->
    {storylet, choice, front, reqs, consq} = qbnEdsl
    {leads} = enums

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
      visible:
        lead: reqs.notexists

    front choice 'jackie',
      'Search for Jackie\'s missing partner'
      'She left for "greener pastures."'
      visible:
        lead: reqs.eq leads.jackie
      next: (jackie) ->
        switch jackie
          when 2 then 'jackie1'

    front choice 'rest',
      'Return home to rest'
      '''
      It's been a long day. Perhaps it's time to go back to your apartment and get some shuteye.

      _This will advance the day by one and reset your hunches._
      '''

    return
