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

      "What? Is that all? You know what I'm going to say. Same thing you would if I came to you,
      Dis. 'Screw off!' What kind of detective would I be if I didn't respect my clients'
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
      she had to seek 'greener pastures,' whatever that means.

      "I'm nothing without her, Dis. I may be the sandpaper skin and muscle of this outfit, but she
      was the brains. This outfit was on hard times before, but it's falling apart without her.

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
      It looks like she's left the city, but she didn't go far. Makes sense; someone had to keep
      those glamours up, and if she trusted anyone else, it'd be a liability. You catch up with her
      at a library. She doesn't remember you, but when you mention who you're working for, she
      drags you into an empty reading room and shuts the door.

      "Dammit," she starts. "I can't believe Jackie hired another gumshoe to hunt me down. Is he
      really that desperate to have me back?"

      You lay out the situation. You explain how Jackie seemed to be falling apart. She snorts.

      "That wasn't me leaving that did that. That stuff was why I left. Jackie's been on the long
      downward slide for years now. Couldn't wrap his thick skull around this new world we all live
      in. Magic befuddles him more than if someone just cast some befuddling magic at him."

      She purses her lips and concentrates on an empty corner of the room. "It's not the paucity of
      jobs I minded, really. Times were always lean. The problem is—" A long pause.

      "He got desperate for work. Started taking hit jobs for the mob. I won't be involved in that
      kind of work again. He knew that, tried to keep it secret from me, but when I found out, I
      knew it had to be over." She sets you with a hard stare. "Don't tell Jackie where I am, Dis.
      It's a complication I
      don't want to deal with, and really, neither does he. I just want to put that past behind me."

      She fishes around in her bag for a moment. "I don't have any info on the Brown
      disappearance to offer you, but I know the fuel you operate on. Hunches, right? I'm trying
      to get better acquainted with the magical world. I picked this thing up from a travelling
      salesman. Helps with detecting hallucinations. If you go back and tell Jackie that you
      couldn't find me, it's all yours."
      '''
      choices: [
        choice 'jackieFinalJackie',
          'Tell Jackie the truth'
          'Honesty is always the best policy, and you need the info on Mr. Brown.'
        choice 'jackieFinalPartner',
          'Take her offer'
          '''
          This is messy and not your responsibility. Plus, that trinket could pay dividends in the
          Brown case and for years to come.
          '''
      ]

    storylet 'jackieFinalJackie',
      'Honesty is always the best policy'
      '''
      You leave her screaming obscenities after you as you leave. If she's smart, she'll be packing
      up and covering her trail again before Jackie arrives.

      You drive straight to Jackie's and spill the beans. He almost runs out before he has time to
      pay up. You drag him back to reality and he hurriedly dumps a huge file on your lap before
      ushering you out and racing towards the suburb where a very awkward shouting match awaits.

      The file explains that Mr. Brown's concerns were as old as time, the bread and butter of the
      sleuthing trade: He thought his wife was cheating on him. Jackie had been gathering photos and
      info for two weeks before Mr. Brown disappeared and the whole file became worthless. And
      judging by the contents, Mr. Brown was right to be worried. Mrs. Brown apparently has some
      very specific interests that were going very unfulfilled by Mr. Brown. Could she be more
      involved than she's letting on? Or, alternatively, could one of the other people pictured be
      behind this?
      '''
      consequences:
        evidence: consq.increase 1
        lead: (quality) ->
          quality.value = undefined
          'Your current lead has ended.'
        jackie: (quality) ->
          quality.value = 3
          'You found Jackie\'s partner for him.'
        progress: consq.set 0

    choice 'jackieFinalPartner',
      'Take Her Offer'
      '''
      You accept the trinket. It's a small figurine — sealbone, if you're any judge — carved in the
      shape of some north sea deity you don't recognize. Jackie's partner seems pleased at your
      acceptance, but she still shoots you a warning glare before departing the library. It's the
      last you ever see of her.

      Jackie is crestfallen but unsurprised to hear of your failure. He seems to sink further into
      his chair as you close the door behind you on the way out. He wouldn't hear of your advice
      to try and adapt to this new world. "Fat lot of good it did you in finding my partner, Dis."
      '''
      consequences:
        sealboneTrinket: consq.increase 1
        lead: (quality) ->
          quality.value = undefined
          'Your current lead has ended.'
        jackie: (quality) ->
          quality.value = 4
          'You did not tell Jackie where his partner is.'
        progress: consq.set 0

    return
