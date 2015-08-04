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
      and shakiest round of not commenting on rumors when the house phone rings. Poor guy. He did
      better than most would have. You hope the higher-ups are lenient with him.

      You are unsurprised to know that your conversation was being seceretly surveiled. But who,
      precisely, was doing the surveiling catches you off-guard for a moment. The clerk is relieved
      and sent on his way by Battherwhite, Esq. herself.

      She sizes you up for a moment. "OK, you'll do." She sits at the table where the clerk had been
      before and picks up the phone. "James, you can stop listening in now. In fact, shut down all
      surveilance of this room. Yes, _all_ of it. Don't question me again on this." She jams the
      receiver down.

      "First of all, I have to thank you for bringing to our attention the public perception of
      our relationship with Mr. Brown. It is rare to get such candid and comprehensive perspective,"
      she says without actually looking at you. "Unfortunately, that thanks doesn't come with
      payment, so don't get excited, Disillusionist."

      She smirks and finally regards you. "Yes, I know who you are. I know who you're working for.
      It would be bad for business not to know, given this company's relationship with the
      deceased." You raise an eyebrow. "Oh, I don't _know_ that he's dead. But it's the only
      reasonable expectation at this point. I'm sure even you suspect as much."

      "Look." she folds her hands. "I'm here to cut a deal for you. What Mr. Brown was doing was…
      not officially for the company. It was a project of a personal nature. For me. "
      '''
      choices: [
        choice 'bribeJackie',
          'Try to bribe him'
          'Jackie looks like he could use the money, and principles won\'t pay the rent.'
          active:
            bluebacks: reqs.gte 6
        choice 'dontBribeJackie',
          'Get lost'
          'Looks like this is a dead end.'
          next: false
      ]
