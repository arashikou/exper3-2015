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

      You glance over the list. A snake charmer? A hypnotist with an ML3 license? A
      transmutationist of foreign citizenship? What could they possibly need all these for?
      '''
      consequences:
        rumor: consq.decrease 10
        lead: consq.set leads.employer
        kbs: (quality) ->
          quality.value++
          'Kimble, Battherwhite, and Smith have employed you as a headhunter.'
        progress: consq.set 0

    storylet 'employer1',
      'Headhunt for KB&S'
      '''
      You know better than to ask what Kimble, Battherwhite, and Smith want with these very
      specific people, but everything you can imagine fills you with dread. Better get this over
      with.
      '''
      choices: [
        choice 'employer1CantripUp',
          'Buy a round of drinks'
          'Being liberal with Cantrip-Up always brings people running.'
          visible:
            progress: reqs.lt 7
          active:
            cantripUp: reqs.gte 3
        choice 'employer1Hunch',
          'Use your hunches'
          '''
          They want a hypnotist. Since you have hypnotism hunches, maybe that's the lead to
          start with.
          '''
          visible:
            progress: reqs.lt 7
          active:
            hypnotismHunch: reqs.gte 1
        choice 'employer1Solve',
          'Aha!'
          'You\'ve actually found what they\'re looking for!'
          active:
            progress: reqs.gte 7
      ]

    storylet 'employer1CantripUp',
      'Buy a round of drinks'
      '''
      You meet many interesting people working the crowd. Some seem like they have potential. Others
      are more than happy to talk about their friends and acquaintances.
      '''
      consequences:
        cantripUp: consq.decrease 3
        progress: consq.increase 1

    storylet 'employer1Hunch',
      'Use your hunches'
      '''
      You find several hypnotists operating further outside the public eye. A strange fellow in
      the university district. The man above the butcher shop. A lady stowing away in the back of
      the mail truck unnoticed.
      '''
      consequences:
        hypnotismHunch: consq.decrease 1
        progress: consq.increase 1

    storylet 'employer1Solve',
      'A most eclectic crew'
      '''
      Against all odds, a group like the one Kimble, Battherwhite, and Smith wants actually exists.
      Though they primarily make their living as musicians now, they all have magical backgrounds
      that match KB&S's needs. And, more importantly, they are keen to make some money putting those
      talents to work. "Beats singing another night for tips at The Red Squirrel."

      The man in the sharp suit is pleased. As the troupe is ushered away to Contractor Orientation,
      he turns back to you. "And don't think I've forgotten your payment. Let me tell you exactly
      what they'll be doing."

      You learn less of use than you'd hoped, and several things you wish perhaps you had never
      known. About ancient religions given new
      relevance in this magical age. About a grand ceremony in the planning. Mr. Brown was not
      actually working for KB&S, _per se_. Rather, he had been employed by Battherwhite, Esq.
      herself to prepare an elaborate ritual basement. You're quite sure she's completely mad, but
      as the sharp-suited man reminds you as he steers you towards the exit, "As you can see, Mr.
      Brown's disappearance puts us at rather a disadvantage, so we couldn't possibly have been
      involved. It's been a great burden on us, until you came along."

      As consolation, he presses a small gemstone on you. "We have dozens, and I think
      someone in your line of work will find it eminently useful."
      '''
      consequences:
        evidence: consq.increase 1
        veinyCarnelian: consq.increase 1
        lead: (quality) ->
          quality.value = undefined
          'Your current lead has ended.'
        kbs: (quality) ->
          quality.value++
          'Kimble, Battherwhite, and Smith no longer require your services.'
        progress: consq.set 0
