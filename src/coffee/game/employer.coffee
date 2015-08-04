angular.module 'gameDefinition.employerStories', ['qbn.edsl', 'gameDefinition.enums']
  .run (qbnEdsl, enums) ->
    {storylet, choice, reqs, consq} = qbnEdsl
    {leads} = enums

    storylet 'employerStart',
      'Mr. Brown\'s last employer'
      '''
      Getting an appointment isn't hard. The hard part is getting an appointment with anyone that
      matters. The clerk that sits across from you is full of platitudes and dry on promises or
      information. It's only when you start letting the word on the street slip, when you start
      talking about Mr. Horace Brown and the things Kimble, Battherwhite, and Smith have been
      rumored to have hired him for that the clerk begins to sweat.

      He is about start on his third
      and shakiest round of not commenting on rumors when the door opens. Poor guy. He did
      better than most would have. You hope the higher-ups are lenient with him.

      That your conversation was being seceretly surveiled is no surprise. The clerk
      is relieved and sent on his way by a man in a sharp suit. You hope that he can prove more
      useful than his predecessor.

      He sizes you up for a moment. "OK, you'll do." He sits at the table where the clerk had been
      before. "James, you can stop listening in now. In fact, cancel all
      surveilance of this room."

      He regards you for a moment before speaking. "I know who you are, and I know who you work for,
      and I would usually be sent down here to tell you that we have nothing to do with any of it
      and kick you on your merry way. However…" He coughs. "Mr. Brown left a great deal of very
      important work undone before he disappeared. We here at Kimble, Battherwhite, and Smith have
      tired of waiting for him to return and are prepared to recontract out that work."

      "Problem is, we do not have a ready pool of sufficiently mystical candidates. And time is of
      the essence. Whereas you have connections in magical society and know many of the players
      there, but you need something we have.
      So here's what we are willing to do: You find us replacements for Mr. Brown and
      we will be willing to share our info on what he was doing here."

      He scoots a folder across the table at you. "We'll need people with all these specialties,
      and they _must_ be used to working together. We don't have time for hellos and tea and cakes."

      You glance over the list. A snake charmer? A hallucinist with an ML3 license? A
      transmutationist of foreign citizenship? What could they possibly need all these for?
      '''
      consequences:
        rumor: consq.decrease 10
        lead: consq.set leads.employer
        kbs: (quality) ->
          quality.value++
          'Kimble, Battherwhite, and Smith have employed you as a headhunter.'
        progress: consq.set 0
