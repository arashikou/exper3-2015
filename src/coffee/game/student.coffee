angular.module 'gameDefinition.studentStories', ['qbn.edsl', 'gameDefinition.enums']
  .run (qbnEdsl, enums) ->
    {storylet, choice, reqs, consq} = qbnEdsl
    {leads} = enums

    storylet 'clubStudent',
      'A nervous-looking student'
      '''
      If they ever throw a rocking chair convention for cats and provide free coffe, it might begin
      to equal this young lady's level of nerves. You make sure to approach from the front, where
      she can see you.

      "What do you want?" she hisses as you slide into the chair opposite.

      You explain yourself.

      "Oh— Oh really? Hey, you might be able to help me! My name's Amber Denotto." She shakes your
      hand. "I'm one of Mr. Brown's students. Or _was_, if the rumors are to be believed. It's
      enough for the university, anyway. They want to reassign me to a new mentor, and that means
      giving up the research materials Mr. Brown provided to me."

      "I'd be willing to part with them to you instead, though. Just… a little tit-for-tat, you
      know? I need your help with something first."

      You pointedly continue listening silently.

      "The seasonal symposium is coming up soon. If I get reassigned and have to start my project
      over, there's no way I stand a chance of placing for a prize, which means no chance of keeping
      my scholarship. Unless… Unless I had some way
      of knowing what competition I'm up against. If I could tailor my new project to the judges
      and make sure it stands out from the competition, I should at least be able to get an
      honorable mention."

      "Do that, and my old project materials from Mr. Brown are yours."
      '''
      consequences:
        lead: consq.set leads.student
        student: (quality) ->
          quality.value++
          'You are helping a student survive the seasonal symposium'
        progress: consq.set 0

    storylet 'student1',
      'Research the seasonal symposium'
      '''
      Information is everywhere at the university. The question is, where to start?
      '''
      choices: [
        choice 'student1Illusion',
          'Research illusions'
          'Search the illusion department for information.'
          visible:
            progress: reqs.lt 7
          active:
            illusionHunch: reqs.gte 1
        choice 'student1Hallucination',
          'Research hallucinations'
          'Speak with the Dean of Hallucinations.'
          visible:
            progress: reqs.lt 7
          active:
            hallucinationHunch: reqs.gte 1
        choice 'student1Hypnotism',
          'Research hypnotisms'
          '''
          As you recall from your own university days, using hypnotism to cheat is practically
          mandatory.
          '''
          visible:
            progress: reqs.lt 7
          active:
            hypnotismHunch: reqs.gte 1
        choice 'student1Solve',
          'That should be enough'
          'You have enough info to give Ms. Denotto a decided edge.'
          active:
            progress: reqs.gte 7
      ]

    storylet 'student1Illusion',
      'Research illusions'
      '''
      You find several groups of students who are preparing illusion presentations for the
      symposium, including one presentation that is actually illusory. They might want to work on
      that further.
      '''
      consequences:
        illusionHunch: consq.decrease 1
        progress: consq.increase 1

    storylet 'student1Hallucination',
      'Research hallucinations'
      '''
      The dean is tight-lipped at first, but you demonstrate appreciation for some of the finer
      hallucinations scattering his office and he begins to warm up and talk about who will be
      featuring at this year's symposium.
      '''
      consequences:
        hallucinationHunch: consq.decrease 1
        progress: consq.increase 1

    storylet 'student1Hypnotism',
      'Research hypnotisms'
      '''
      Sure enough, several students are already preparing their hypnotisms to try and trick the
      judges. It was probably never going to work, but turning them in reduces Ms. Denotto's
      competition and gets you brownie points with people who can leak details of the symposium.
      '''
      consequences:
        hypnotismHunch: consq.decrease 1
        progress: consq.increase 1

    storylet 'student1Solve',
      'Hope springs eternal'
      '''
      Ms. Denotto seems very pleased with the results you deliver. She's practically licking her
      lips with excitement at her prospects. "With this much, I could probably even _place_ at
      the symposium. I should have hired you years ago!"

      She's all too happy to part with her old research materials. You are shocked to discover that
      Mr. Brown provided her with a live demon in a cage. The things are exceedingly rare, and just
      seeing the little fiend's golden compound eyes takes your mind back to times better left
      forgotten.

      Ms. Denotto misinterprets your reverie as concern. "Don't worry, this is
      totally legal. Here—" She hands you a sheaf of papers. "These papers prove that he's
      legitimate, culled from the old battlefields and not some demonologist's weekend mistake."

      The other materials are nothing so interesting. Indeed, you'll probably just hock them later.
      But as she reaches to hand over the last packet, Amber stops. "Can I— Can I keep just one
      thing? To remember him by. Mr. Brown was actually quite good as a mentor."

      She opens the packet to reveal two tiny objects. "Go ahead, take either one you like. Just
      leave the other one for me."
      '''
      choices: [
        choice 'studentFinalSealbone',
          'Take the sealbone figurine'
          'Sealbone carvings like this are often sensitive to hallucinations.'
        choice 'studentFinalRibbon',
          'Take the inscribed ribbon'
          'The inscriptions are supposed to protect the bearer against illusions.'
      ]

    finalText =
      '''
      Amber nods and closes the packet. "If you ever change your mind, I bet the dealer in the
      Salamader Club could help you. He's always helping students swap things we've been
      overallocated for things we can't get."
      '''

    storylet 'studentFinalSealbone',
      'A sealbone figurine'
      finalText
      consequences:
        cagedDemon: consq.increase 1
        bluebacks: consq.increase 3
        sealboneTrinket: consq.increase 1
        lead: (quality) ->
          quality.value = undefined
          'Your current lead has ended.'
        student: (quality) ->
          quality.value++
          'Your help has been invaluable to Ms. Denotto'
        progress: consq.set 0

    storylet 'studentFinalRibbon',
      'An inscribed ribbon'
      finalText
      consequences:
        cagedDemon: consq.increase 1
        bluebacks: consq.increase 3
        inscribedRibbon: consq.increase 1
        lead: (quality) ->
          quality.value = undefined
          'Your current lead has ended.'
        student: (quality) ->
          quality.value++
          'Your help has been invaluable to Ms. Denotto'
        progress: consq.set 0
