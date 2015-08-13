angular.module 'gameDefinition.roxyStories', ['qbn.edsl', 'gameDefinition.enums']
  .run (qbnEdsl, enums) ->
    {storylet, choice, reqs, consq} = qbnEdsl
    {leads} = enums

    storylet 'roxyStart',
      'Roxy Malone, big-time gangster'
      '''
      There are three big gangs in the city. North of the river belongs to Mac Turleigh's boys.
      The financial district is under the watchful eye of Ambrose Beard. And everything else?
      Everything else belongs to Roxy Malone's gang.

      Roxy appeared during the war, already leading a small gang of street toughs. While the old
      gangs had their eyes turned to war profiteering, she was qietly eating away at their
      territory back home. While the old gangs were trying to understand how to get mages to work
      for them, she was already an accomplished sorceress in her own right. Roxy was a native of
      the new world. And one by one, the old gangs fell before her or joined her outright. Smart
      money says she won't rest until she owns the whole city.

      So why is she concerning herself with Mrs. Brown? What does she have to gain from driving a
      grieving woman from her home? There's more going on here than meets the eye.

      This won't be the first time you two have crossed paths, but you don't know where she's
      operating out of these days. You'll need to get a bead on Roxy before you can confront her.
      '''
      choices: [
        choice 'findRoxy',
          'Begin searching for her'
          'You\'re going to need to do some investigation just to find a place to start looking.'
          active:
            rumor: reqs.gte 6
        choice 'dontFindRoxy',
          'No good'
          'Roxy is still giving you the slip.'
          next: false
      ]

    storylet 'findRoxy',
      'Begin searching for her'
      '''
      There's a through-line to the stories on the street about Roxy's gang. For the last six
      months, they've been having
      trouble bringing enough people to bear to pressure the other gangs. And they're more focused
      on consolidating power in the magic districts. It all adds up to one thing: Roxy must have
      moved her base of operations east, away from downtown… and right into the vicinity of
      the Brown mansion.

      Based on shakedown rates in various districts, you figure Roxy's hideout must be somewhere
      within an area of about fifteen blocks on the east end. It's still a wide area, but it's a
      start.
      '''
      consequences:
        lead: consq.set leads.roxy
        roxy: (quality) ->
          quality.value++
          'You know where to start looking for Roxy'
        progress: consq.set 0

    storylet 'roxy1',
      'Pursue Roxy the gangster'
      '''
      No operation as large as Roxy's can avoid leaving a trail behind.
      '''
      choices: [
        choice 'roxy1Bluebacks',
          'Pay off low-level scum'
          'The lowest man on the totem pole is usually the most willing to trade money for secrets.'
          visible:
            progress: reqs.lt 5
          active:
            bluebacks: reqs.gte 3
        choice 'roxy1Hunch',
          'Look for unusual illusions'
          '''
          A wizard like Roxy is bound to be using huge numbers of illusions to cover up her
          operations.
          '''
          visible:
            progress: reqs.lt 5
          active:
            illusionHunch: reqs.gte 1
        choice 'roxy1Solve',
          'Aha!'
          'You\'ve pieced together enough to find her!'
          active:
            progress: reqs.gte 5
      ]

    storylet 'roxy1Bluebacks',
      'Pay off low-level scum'
      '''
      None of them have been to the headquarters directly. Most of them are at least two tiers
      removed from anyone important enough to know anything. But who they meet and where they meet
      them tells you a lot about who to pay off next and where the orders are coming from.
      '''
      consequences:
        bluebacks: consq.decrease 3
        progress: consq.increase 1

    storylet 'roxy1Hunch',
      'Look for unusual illusions'
      '''
      There are illusions all over this part of town, of course. When using a spell to spruce up
      your home is so easy, why not do it? Still, a few places with an unusual number and specificty
      of illusions catch your eye, particularly the ones with illusions in places that have nothing
      to do with decor.
      '''
      consequences:
        illusionHunch: consq.decrease 1
        progress: consq.increase 1

    storylet 'roxy1Solve',
      'In a disused print shop'
      '''
      The print shop's shell only takes up a small portion of the first floor, but it's been
      magicked to appear larger than it is, to cover up the fact that the rest of the building is
      filled with gangsters.

      Roxy won't deign to see you if you just walk up to the front door. Not after what happened
      last time. So it looks like breaking and entering is your only option. You slip in a back door
      and slide through a hallucinatory wall. You're upstairs and rifling through files without
      anyone being the wiser. Their contents aren't very revealing, though. Nothing in here really
      explains the link to Mr. Brown.

      You've just spotted a locked cabinet in the corner and are considering how to best open it
      when a lowly runner wanders in and spots you. He rushes out and sounds the alarm. Cursing your
      luck, you shoot the lock off. Inside is a stack of envelopes and a small, magical charm.

      You're going to need a hand free to hold your gun. Which do you take?
      '''
      choices: [
        choice 'roxyFinalLetters',
          'Take the letters'
          'They smell… nice?'
        choice 'roxyFinalRibbon',
          'Take the spell-inscribed ribbon'
          '''
          You've seen these before. They're used to overcome illusions.
          '''
      ]

    storylet 'roxyFinalLetters',
      'Mysterious letters'
      '''
      Once safely back in your office, you peruse the letters with great curiosity. They appear to
      be love letters. You have no idea who this Joy person is, nor who she was writing to, but
      the smell of perfume on them is tugging at your memory, as if you've smelled it before. And
      whoever she is, she uses the post office near Mr. Brown's mansion.
      '''
      consequences:
        evidence: consq.increase 1
        lead: (quality) ->
          quality.value = undefined
          'Your current lead has ended.'
        roxy: (quality) ->
          quality.value = 3
          'You stole some letters from Roxy Malone\'s hideout.'
        progress: consq.set 0

    storylet 'roxyFinalRibbon',
      'A magic ribbon'
      '''
      Once safely back in your office, you confirm what you already suspected. The ribbon is a charm
      against illusions, inscribed with a spell of protection. It isn't the evidence in the case
      that you were looking for, but it should be very useful in continuing your investigation.
      '''
      consequences:
        inscribedRibbon: consq.increase 1
        lead: (quality) ->
          quality.value = undefined
          'Your current lead has ended.'
        roxy: (quality) ->
          quality.value = 4
          'You stole a ribbon from Roxy Malone\'s hideout.'
        progress: consq.set 0

    return
