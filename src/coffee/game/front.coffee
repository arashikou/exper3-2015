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

    front choice 'employer',
      'Headhunt for KB&S'
      'They have some very specific needs.'
      visible:
        lead: reqs.eq leads.employer
      next: (kbs) ->
        switch kbs
          when 1 then 'employer1'

    front choice 'cop',
      'Follow up on Dentley\'s tip'
      'He said you\'d want to see this.'
      visible:
        lead: reqs.eq leads.cop
      next: (cop) ->
        switch cop
          when 1 then 'cop1'

    front choice 'student',
      'Research the seasonal symposium'
      'Ms. Denotto needs to know about her competition and the judges.'
      visible:
        lead: reqs.eq leads.student
      next: (student) ->
        switch student
          when 1 then 'student1'

    front choice 'roxy',
      'Pursue Roxy the gangster'
      'She wants Mrs. Brown out of town. But why?'
      visible:
        lead: reqs.eq leads.roxy
      next: (roxy) ->
        switch roxy
          when 2 then 'roxy1'

    front choice 'dealerFront',
      'Visit the Rarities Dealer'
      'Perhaps you have something he\'d like to trade.'
      visible:
        dealer: reqs.gte 1

    front choice 'rest',
      'Return home to rest'
      '''
      It's been a long day. Perhaps it's time to go back to your apartment and get some shuteye.

      _This will advance the day by one and reset your hunches._
      '''

    return
