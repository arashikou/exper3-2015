angular.module 'gameDefinition.endingStories', ['qbn.edsl', 'gameDefinition.enums']
  .run (qbnEdsl, enums) ->
    {storylet, choice, reqs, consq} = qbnEdsl
    {leads} = enums

    storylet 'solve1',
      'A cold day'
      '''
      Your hand hesitates, just a moment, before knocking on Mrs. Brown's door. You have the answers
      she wanted, but is this really going
      to make her life any better? What does justice even mean in a situation like this one? To
      walk away and leave the case unsolved might be the kindest thing for all involved and the
      closest thing to justice that could come from this.

      But you don't get paid to make those kinds of calls. You get paid to deliver information. And
      that's what you're here to do, at long last, for Mrs. Brown. This isn't the first time the
      news hasn't been what your client was hoping for. It may be a situation that's unique in your
      experience — and likely anyone else's — but it's no different in that way than breaking the
      news to someone that their spouse is a cheating bastard or that their loved one's current
      address is in the city morgue.

      You turn and glance at your companions. One is a wizard friend from the old days. You'll owe
      him a favor for this, and you're not looking forward to repaying it. The other
      is an ex-boxer that owes _you_ a favor for helping him clear his name and reputation a few
      years ago. Both are going to be essential to surviving today.
      '''
      choices: [
        choice 'solve2',
          'Knock and get this over with'
      ]

    storylet 'solve2',
      'A sharp knock'
      '''
      You are promptly admitted. Your companions draw a few raised eyebrows, but you insist that
      they are vital to your
      investigation. You also insist on meeting Mrs. Brown at the scene of the crime. It's dramatic,
      perhaps, but not half as dramatic as what you're here to do.

      Once you've been left alone with Mrs. Brown, you regard her for a long moment. The illusion is
      almost perfection. Whoever created her knew Mrs. Brown better than anyone in this world. And
      the wards in place to dissuade magical detection are advanced sorcery of the highest caliber.
      This is the work of a master, no doubt about it, and a master with intimate knowledge of
      Mrs. Brown. To anyone not in posession of your particular talents and knowledge, it would be
      impossible to tell.

      "Why— Why are you staring at me?" she stammers.

      You don't answer. Instead, you inform her that you have found Mr. Brown.
      You explain that her husband is, in fact, not dead. This
      news heartens her, to your dismay.

      "Where is he, then?!?" she gasps. "Has he been kidnapped? Is he— is he hiding?"
      '''
      choices: [
        choice 'solve3',
          '"Bring him out, Jim."'
      ]

    storylet 'solve3',
      'A man revealed'
      '''
      Your wizard friend begins to weave his work. There is a feeling like an oncoming storm, of the
      pressure in the room dropping. He's lowered the ambient warpweave levels in order to isolate
      the illusions at play.

      And then, all at once, the illusion breaks. Mrs. Brown is like so much water, dumped out of
      a dirty bucket. She washes away onto the floor, leaving behind a confused, weak-kneed,
      mustachioed man in a fawn suit.

      "What? What the devil? Where am—"

      You don't give him time to finish.
      '''
      choices: [
        choice 'solve4',
          '"Now! Pin him!"'
      ]

    storylet 'solve4',
      'A man revealed'
      '''
      The boxer is on him in a moment. He's up against the wall before he has time to recover his
      senses. The wizard continues to keep the warpweave out, in hopes of denying him access to
      magic. You breathe a sigh of relief. Exposing Mr. Horace Brown was easy enough, but locking
      him down before he could escape was a risk.

      It wasn't Mr. Brown that disappeared that night. It was Mrs. Abigail Brown. You never actually
      met her because she was already dead before you got involved.

      She'd been cheating on Mr.
      Brown. With evidence of her infidelity in hand, Horace had confronted her. There'd been a
      fight. A fight that got physical. A fight that got magical.
      And at a clear disadvantage in that situation, Abigail Brown had died, and her body had ended
      up in the river. Mr. Brown used his connections to shush the police from investigating.
      And that might have been the end of
      it, if not for the intervention of a third party.

      A third party that thinks you don't know she's creeping in the window behind you.
      '''
      choices: [
        choice 'solve5',
          '"Hello, Roxy."'
      ]

    storylet 'solve5',
      'A woman revealed'
      '''
      You hear the click of a revolver cocking from behind you.

      "Dis. I can't believe you were really fool enough to undo it. To bring that monster back into
      this world. What the hell do you think you're doing?!?"

      Ah, Roxy. Roxy the gang leader. Roxy the sorceress. As you suspected, she was Mrs. Brown's
      lover. She found Mr. Brown with the body and transformed him into the simulacrum that has been
      living as Mrs. Brown for the last few weeks. The one that hired you to look for the missing
      husband that was right under her nose the whole time.
      '''
      choices: [
        choice 'solve6',
          '"Why did you do it, Roxy?"'
      ]

    storylet 'solve6',
      'A fate resolved'
      '''
      "Why?!? Because he took something beautiful and wonderful away! Because she
      deserved to be in this world and he didn't anymore! So I made him disappear and tried to bring
      her back. I made him into her, body and mind. But—" There's a frustrated growl.
      "It wasn't enough. It wasn't the same. I couldn't forget who was
      underneath her skin. It was torture to be around him. But I couldn't bring myself to undo the
      illusion; it would be like killing her all over again myself.
      So I erased myself from her memory and
      tried to scare her out of town. Out of sight, and someday out of mind.

      "Surely you understand, Dis.
      Just as I'm sure you know you can't just take him to the police now. He's got them in his
      pocket. And a master sorcerer like him? Even if they convicted him, they'd never
      hold him."

      She steps where you can see her and levels her gun at Mr. Brown. "The only way to ensure that
      Abigail gets justice is to end him myself."
      '''
      choices: [
        choice 'solve7-roxy',
          'Let Roxy shoot him'
        choice 'solve7-nobody',
          'Stop Roxy'
        choice 'solve7-dis',
          'Shoot him yourself'
      ]

    epilogue = choice 'epilogue',
      'And so the story ends…'

    storylet 'solve7-roxy',
      'A fate resolved'
      '''
      The gunshot rings across the parlor, drowning out all other noise. Blood begins to spread
      across Mr. Brown's body, soaking into the wall behind him. Your boxer stumbles backwards in
      surprise, dropping the now-dead Mr. Brown. He flops to the ground like a puppet without
      strings.

      There's a thump behind you, and you feel the magical pressure return to the room. Turning
      around, you see your wizard knocked out. There's footsteps rushing towars the door, but Roxy
      is already gone. There's just a twinkling of blue light where she once stood.

      The next week is hell for you and your companions. With Mr. Brown dead, the police no longer
      have an incentive to overlook this case and launch a full investigation. Eventually,
      though, they have to let you go. Your gun wasn't fired that night, and it doesn't match the
      bullet's caliber anyway. Your partners weren't
      packing. Besides, the idea that a notorious gangland master did the killing isn't a hard sell.

      They dismiss your wild stories about illusory women and broken hearts, though.
      Instead, they pin Roxy
      with the blame for Mrs. Brown's death as well. If the police ever catch up with her, it'll be
      a very bitter day.
      '''
      choices: [
        epilogue
      ]

    storylet 'solve7-nobody',
      'A fate resolved'
      '''
      The gunshot rings across the parlor, drowning out all other noise.

      "Curse you, Dis!" Roxy screams as she knocks you away and takes aim for a second attempt.

      But there's no one to aim at. Behind you, you hear a thump, and you feel the magical
      pressure return to the room. Turning
      around, you see your wizard knocked out. For a moment, you see Mr. Brown standing over him,
      but then there is only a twinkling of blue light.

      "I'll get you, Horace Brown! You can't run from me!" And moments later, Roxy is gone in a
      similar twinkling.

      The police aggressively ignore your attempts to explain the whole incident. With Mr. Brown
      potentially alive, they're still under the gun to keep this secret. You and your
      companions are released after a day of cursory interviewing with an unsubtle warning to keep
      your mouths shut.

      If ther's a silver lining to all this, it's that this is the last you hear of Horace Brown
      _or_ Roxy. Whether she abandoned her post to chase her lover's murderer or she was beaten by
      her quarry, you don't know. But Roxy never returns to lead her gang, and eventually they
      succumb to internal
      strife between those warring for her position. The police get significant portions of her
      gang, and others still are killed in the conflict.

      All told, the city is a little safer.
      For now.
      '''
      choices: [
        epilogue
      ]

    storylet 'solve7-dis',
      'A fate resolved'
      '''
      Two gunshots ring across the parlor. One from Roxy's gun… and one from yours. You couldn't say
      which one actually felled Mr. Brown, but he now sports two bleeding wounds that are quickly
      marring his suit with blood.

      You hear the sound of footsteps rushing outside at the same time as you feel the warpweave
      rush back into the room. Your wizard is so shocked that he's forgotten to do his job. This
      proves to be in your favor, however.

      In a flash of blue light, you suddenly find yourself
      on the roof of Roxy's headquarters. She's teleported both of you away from the crime scene.
      There, she fixes you with a stern glare.

      "What the hell was that, Dis? What did you think you were doing?"
      '''
      choices: [
        choice 'solve8-fordis',
          '"Mrs. Brown deserved justice."'
        choice 'solve8-forroxy',
          '"I didn\'t want to see your hands soiled in this."'
        choice 'solve8-shoot',
          'Shoot Roxy'
      ]

    storylet 'solve8-fordis',
      'A fate resolved'
      '''
      Roxy laughs. "You still fancy yourself as some kind of hero?" Her gun is
      suddenly in her hand. "Listen, Dis. That vengeance was mine and mine alone. You don't get to
      take that from me." There is a tense moment before she continues. "So unless you want to end
      up very dead, you are going to agree that I shot him first and then—" She shoves the gun
      towards you. "_Never_ cross me again. But your did it for Abigail, so this one time, I'll let
      you leave alive."

      It leaves a bitter taste in your mouth, but you consent to her version of events.
      As you're opening the door to the stairs, you hear Roxy say
      "You know, if you want a place to hide out now that you're a wanted criminal, my
      organization could use a person like you, Dis."

      It's an offer you may have to consider.
      '''
      choices: [
        epilogue
      ]

    storylet 'solve8-forroxy',
      'A fate resolved'
      '''
      Roxy snorts and furrows her brow angrily. "Like my hands aren't already bloody. I'm not some
      delicate flower for you to protect."
      Her gun is suddenly in her hand. "That's not a call you get to make, Dis."

      And then your world goes black.
      '''
      choices: [
        epilogue
      ]

    storylet 'solve8-shoot',
      'A fate resolved'
      '''
      Roxy coughs in surprise and falls to the rooftop.

      At last, every criminal in this case has
      been dealt with. Mrs. Brown's murderer is dead, and so is the woman who took Mr. Brown's
      identity away from him.

      Solemnly, you walk over to Roxy's body and take her gun. It's going to take every bullet
      you have and a fair bit of luck to get out of here alive.

      But at least you can be sure that
      justice, as far as you're concerned, was served today.
      '''
      choices: [
        epilogue
      ]

    storylet 'epilogue',
      'Thanks for reading'
      '''
      Thank you for playing **The Disillusionist**, my entry in the 2015 EXPER3 challenge. I hope
      you enjoyed the experience. Perhaps, if you did not get the ending you wanted or if there are
      leads you haven't followed up on, you may want to hit that reset button in the corner and try
      again.

      Writing this game has been eye-opening for me and a great challenge. I won't pretend it isn't
      without its flaws, but I'm proud of it considering it's my first fiction writing in over a
      decade. If you didn't enjoy the experience, then I apologize, and you can get a full refund of
      your $0. In fact, I've already sent it to you.

      Thank you for coming on this journey with me.

      —John Bruce, 2015-08-12
      '''
      choices: [
        choice 'dummy',
          undefined
          undefined
          visible:
            keyOfDreams: reqs.exists
      ]

    return
