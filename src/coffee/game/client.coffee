angular.module 'gameDefinition.clientStories', ['qbn.edsl', 'gameDefinition.enums']
  .run (qbnEdsl, enums) ->
    {storylet, start, choice, front, retreat, onwards, reqs, consq} = qbnEdsl
    {leads, origins} = enums

    storylet 'botherClient',
      'Visit the client'
      '''
      Mrs. Brown is at home when you arrive. A servant offers to fetch her. Are you here to see her
      or to investigate the crime scene?
      '''
      choices: [
        choice 'solveEvidence',
          'Solve the case with evidence'
          '''
          But if this… Then that… Which means…
          '''
          active:
            evidence: reqs.gte 10
            keyOfDreams: reqs.exists
        choice 'solveHunch',
          'Solve the case with pure gumption'
          '''
          Something about this situation doesn't seem right. Damn collecting evidence; with enough
          hunches, you could blow this case wide open!
          '''
          active:
            illusionHunch: reqs.gte 3
            hallucinationHunch: reqs.gte 3
            hypnotismHunch: reqs.gte 3
            keyOfDreams: reqs.exists
        choice 'advanceAsk',
          'Ask for an advance'
          '''
          This case is taking a while, and the retainer's running thin. It's time to hit up the
          client for more money.
          '''
          visible:
            day: reqs.gte 3
            advance: reqs.notexists
        choice 'askClient1',
          'Ask for more info'
          '''
          You feel like maybe there's something she hasn't told you yet.
          '''
          visible:
            jackie: reqs.lte 0
        choice 'askClient2',
          'Ask what\'s wrong'
          '''
          When you arrive, the sound of Mrs. Brown's sobbing fills the house. Something is
          definitely up.
          '''
          visible:
            day: reqs.gte 5
            roxyThugDescription: reqs.lte 0
        choice 'crimeScene',
          'Inspect the crime scene'
          'There are bound to be clues the police\'s half-hearted investigation missed.'
      ]

    # TODO: storylet 'solveEvidence'

    # TODO: storylet 'solveHunch'

    setBothered = (bothered) ->
      bothered.value = true
      'Mrs. Brown does not wish to see you again today.'

    storylet 'advanceAsk',
      'Ask for an advance'
      '''
      Mrs. Brown is a little less free with her funds this time. Perhaps she expected the case to
      be resolved by now, in which case she's a fool. Or perhaps she showed the contract to one of
      her accountants, in which case she's less-so. Nonetheless, you are able to draw a little blood
      from the stone before being sent on your way with a reminder to earn that money.
      '''
      consequences:
        bluebacks: consq.increase 6
        bother: setBothered
        advance: (quality) ->
          quality.value = true
          'You will not be able to ask for an advance again.'

    storylet 'askClient1',
      'Ask for more info'
      '''
      "Actually, there is something new," she purrs. "While I was going through Horry's old things,
      I came across this receipt."

      She hands you a receipt almost identical to the one you made out for her in your office.

      "It seems I wasn't the first one to employ a private detective. Though what he hired this
      'Jackie' for, I couldn't say."

      You know Jackie. He's one of the old guard. He was in this business before the war, before
      magic. Hell, maybe before you were even born. The new world hasn't been kind to him, though,
      and word is he fell on hard times recently. Maybe hard enough to get him to parley with the
      competition? It's not much, but it's a start.
      '''
      consequences:
        jackie: (quality) ->
          quality.value++
          'You have received a receipt from Mrs. Brown.'
        bother: setBothered

    storylet 'askClient2',
      'Ask what\'s wrong'
      '''
      "Oh, it's horrible! You just missed them! Two thugs were here, making threats! Warning
      me to stop the investigation! Telling me to leave town!"

      After you calm Mrs. Brown down, you get a description of the thugs. The purple carnation
      lapel pins make them
      easy to identify. These boys belonged to Roxy Malone, one of the three biggest gangsters in
      the city. What Roxy's stake in this is, you have no idea, but you aim to ask her.

      You make a point of not asking if Mrs. Brown wants the investigation called off, and she
      doesn't make a point of telling you. This one is too juicy to let slip away.
      '''
      consequences:
        roxyThugDescription: consq.increase 1
        bother: setBothered

    storylet 'crimeScene',
      'Inspect the crime scene'
      '''
      Mrs. Brown has a servant let you into the witching parlor. She can't bear to look at it
      herself. What are you looking for?
      '''
      choices: [
        choice 'crimeSceneIllusion',
          'Evidence of illusions'
        choice 'crimeSceneHallucination',
          'Evidence of hallucinations'
        choice 'crimeSceneHypnotism',
          'Evidence of hypnotisms'
        choice 'crimeSceneRumor',
          'Information in Horace Brown\'s files'
        choice 'crimeSceneDrink',
          'Actually, I\'m here to raid the liquor cabinet'
        choice 'leaveUntouched',
          'Leave the crime scene untouched'
          'On second thought, maybe coming here was a bad idea.'
          next: false
      ]

    storylet 'crimeSceneIllusion',
      'Evidence of illusions'
      '''
      Someone on the house staff has been using illusions to hide subpar housework. It's amateur
      stuff, but it confounds your search. Nonetheless, there has definitely been a more
      competent illusionist
      at work here as well. But was it Brown or someone else?
      '''
      consequences:
        illusionHunch: consq.increase 1
        bother: setBothered

    storylet 'crimeSceneHallucination',
      'Evidence of hallucinations'
      '''
      If there were any hallucinations here, they've been cleaned up. But sometimes a hallucination
      is telling by its absence. There are three suspicious gaps in the decor on the wall opposite
      the windows. By the looks of it, there were hallucinations here for quite some time; the
      staff had been cleaning around them. Were they Brown's work? Or somehow related to his
      disappearance?
      '''
      consequences:
        hallucinationHunch: consq.increase 1
        bother: setBothered

    storylet 'crimeSceneHypnotism',
      'Evidence of hypnotisms'
      '''
      Your brain is on fire. Here, by the workbench. Judging by the height, the person was in the
      process of standing up. And over here, by the window. But this one, it was a different person
      than the first…
      '''
      consequences:
        hypnotismHunch: consq.increase 1
        bother: setBothered

    storylet 'crimeSceneRumor',
      'Information in Horace Brown\'s files'
      '''
      You don't turn up any evidence relevant to the case, but you do turn up some juicy tidbits
      that you're pretty sure aren't public knowledge.
      '''
      consequences:
        rumor: consq.increase 3
        bother: setBothered

    storylet 'crimeSceneDrink',
      'Raiding the liquor cabinet'
      '''
      Alas, the liquor has been removed, perhaps against just such an eventuality. But you are
      able to snag a few Cantrip-Ups that you don't imagine will be missed.
      '''
      consequences:
        cantripUp: consq.increase 3
        bother: setBothered

    return
