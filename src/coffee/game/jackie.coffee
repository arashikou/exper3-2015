angular.module 'gameDefinition.jackieStories', ['qbn.edsl', 'gameDefinition.enums']
  .run (qbnEdsl, enums) ->
    {storylet, choice, reqs, consq} = qbnEdsl
    {leads} = enums

    storylet 'jackieStart',
      'Jackie, old-school detective'
      '''
      Jackie is in his office when you find him. It's never a good sign if Jackie is in his
      office. It means he's too out of work to be busy and too despondent to be drinking. Judging
      by his state, times are even tougher than you thought.

      "Oh god, it's you," he mutters as you enter. "And to what do I owe the pleasure of the great
      Disillusionist's presence?"

      You explain about Horace Brown.

      "What? Is that all? You know what I'm going to say. Same thing you would if I came to you.
      'Screw off!' What kind of detective would I be if I didn't respect my clients'
      confidentiality? People come here for all sorts of private stuff. I'd be out of work in no
      time if I started spilling their beans."

      You suppress the urge to argue that, point of fact, it doesn't look like anyone has been
      coming here for _any_ sort of stuff lately. Instead, you appeal to the point that Mr. Brown
      is missing, possibly dead, and this could help lead to his rescue.

      "That just makes it worse. If he's dead, he can't tell anyone whether he'd give a damn about
      my secrecy, can he? Get lost, pal. These lips are sealed."
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

    storylet 'bribeJackie',
      'Try to bribe him'
      '''
      For a long moment, Jackie hungrily eyes the bills in your hand. But just when you think he's
      going to take your offer—

      "Put that away." He slumps in his chair. "This is really that important to you, huh?"

      He eyes the empty desk on the opposite side of the room. "She's gone. Did you even notice?"
      Come to think of it, where _is_ his partner? "Just up and stormed out a few weeks ago. Said
      she had to seek 'greener pastures,' whatever that means. That doesn't sound like her at all,
      though. Something's not right."

      "I've tried to find her, but she's fallen off the map so well, I can't even get a whiff of
      her. But then, she knows all my techniques; she's better-qualified than anyone to avoid me.
      But you! You, she isn't so well-equipped to avoid. Find her for me, and I'll forget about
      detective-client confidentiality for a bit as regards the quite-likely-late Mr. Brown and his
      concerns."
      '''
      consequences:
        lead: consq.set leads.jackie
        jackie: (quality) ->
          quality.value++
          'Jackie has asked you to find his partner.'
        progress: consq.set 0

    storylet 'jackie1',
      'Search for Jackie\'s missing partner'
      '''
      She's gone to ground, or maybe left the city entirely. You need to pick up her trail.
      '''
      choices: [
        choice 'jackie1Rumor',
          'Hit the streets'
          'Ask around. Try not to be too obvious. Someone must have seen _something_.'
          visible:
            progress: reqs.lt 5
          active:
            rumor: reqs.gte 3
        choice 'jackie1Hunch',
          'See if you get any hunches'
          '''
          She wasn\'t a mage, but then, neither is Jackie. Maybe she\'s using magic to cover her
          tracks from him.
          '''
          visible:
            progress: reqs.lt 5
          active:
            hallucinationHunch: reqs.gte 1
        choice 'jackie1Solve',
          'Aha!'
          'You\'ve pieced together enough to find her!'
          active:
            progress: reqs.gte 5
      ]

    storylet 'jackie1Rumor',
      'Hit the streets'
      '''
      You don\'t get any info on her directly, but the omissions in the stories are almost as
      telling as the stories themselves.
      '''
      consequences:
        rumor: consq.decrease 3
        progress: consq.increase 1

    storylet 'jackie1Hunch',
      'See if you get any hunches'
      '''
      There's traces of it all over the building where Jackie's office is. Little scraps of
      store-bought hallucinations, nothing elaborate. But telltale signs that she's been trying
      to keep him off her trail.
      '''
      consequences:
        hallucinationHunch: consq.decrease 1
        progress: consq.increase 1

    storylet 'jackie1Solve',
      'Out of the city, but not far'
      '''
      It looks like she's left the 
      '''
      active:
        progress: reqs.gte 5

    return
