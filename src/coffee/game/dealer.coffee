angular.module 'gameDefinition.dealerStories', ['qbn.edsl', 'gameDefinition.enums']
  .run (qbnEdsl, enums) ->
    {storylet, choice, reqs, consq} = qbnEdsl
    {leads} = enums

    storylet 'clubDealer',
      'A dealer in rarities'
      '''
      You can't even open your mouth before the rarities dealer recognizes you for what you are.
      "How the hell did you even get in here, you burnout!? Where's security?"

      Before he can summon anyone, you slam the demon cage down on the table. It shuts him right
      up. At his quizzical stare, you produce the demon's papers. He looks them over, then looks
      them over again, unable to believe that someone as mundane as yourself could get your
      hands on such an esoteric item.

      Finally, he grunts his assent. "I'll concede, you are something special. I don't have any use
      for it, but I'll put it up for sale. If anyone wants the little bastard, you get 50% after
      taxes.
      And if you're interested in making any other trades, why not come by my shop later yourself?"
      He produces a card with an address and a password.
      '''
      consequences:
        cagedDemon: consq.decrease 1
        dealer: consq.set 1

    storylet 'dealerFront',
      'A dealer in rarities'
      '''
      Despite your having earned enough of his respect to get into his shop, the dealer still fixes
      you with a wary glare.

      "Well, go on. What is it you want?"
      '''
      choices: [
        choice 'dealerRibbon',
          'Trade an inscribed ribbon'
          undefined
          active:
            inscribedRibbon: reqs.gte 1
        choice 'dealerSealbone',
          'Trade a sealbone trinket'
          undefined
          active:
            sealboneTrinket: reqs.gte 1
        choice 'dealerCarnelian',
          'Trade a veiny carnelian'
          undefined
          active:
            veinyCarnelian: reqs.gte 1
      ]

    escapeChoice = choice 'dealerEscape',
      'On second though, maybe not…'
      '_Return to the main screen._'

    dealerBlather = '"Oh? And what do you want for it?"'
    dealerSealed =
      '"Very well, I accept! And any time you want to trade again, you know where to find me!"'

    storylet 'dealerRibbon',
      'Trade an inscribed ribbon'
      dealerBlather
      choices: [
        choice 'dealerRibbonForSealbone',
          'Trade for a sealbone trinket'
          'This trinket will help you detect hallucinations.'
        choice 'dealerRibbonForCarnelian',
          'Trade for a veiny carnelian'
          'This gem will help you detect hypnotisms.'
        escapeChoice
      ]

    storylet 'dealerRibbonForSealbone',
      'Trade ribbon for sealbone'
      dealerSealed
      consequences:
        inscribedRibbon: consq.decrease 1
        sealboneTrinket: consq.increase 1

    storylet 'dealerRibbonForCarnelian',
      'Trade ribbon for carnelian'
      dealerSealed
      consequences:
        inscribedRibbon: consq.decrease 1
        veinyCarnelian: consq.increase 1

    storylet 'dealerSealbone',
      'Trade a sealbone trinket'
      dealerBlather
      choices: [
        choice 'dealerSealboneForRibbon',
          'Trade for an inscribed ribbon'
          'This ribbon will help you detect illusions.'
        choice 'dealerSealboneForCarnelian',
          'Trade for a veiny carnelian'
          'This gem will help you detect hypnotisms.'
        escapeChoice
      ]

    storylet 'dealerSealboneForRibbon',
      'Trade sealbone for ribbon'
      dealerSealed
      consequences:
        sealboneTrinket: consq.decrease 1
        inscribedRibbon: consq.increase 1

    storylet 'dealerSealboneForCarnelian',
      'Trade sealbone for carnelian'
      dealerSealed
      consequences:
        sealboneTrinket: consq.decrease 1
        veinyCarnelian: consq.increase 1

    storylet 'dealerCarnelian',
      'Trade a veiny carnelian'
      dealerBlather
      choices: [
        choice 'dealerCarnelianForRibbon',
          'Trade for an inscribed ribbon'
          'This ribbon will help you detect illusions.'
        choice 'dealerCarnelianForSealbone',
          'Trade for a sealbone trinket'
          'This trinket will help you detect hallucinations.'
        escapeChoice
      ]

    storylet 'dealerCarnelianForRibbon',
      'Trade carnelian for ribbon'
      dealerSealed
      consequences:
        veinyCarnelian: consq.decrease 1
        inscribedRibbon: consq.increase 1

    storylet 'dealerCarnelianForSealbone',
      'Trade carnelian for sealbone'
      dealerSealed
      consequences:
        veinyCarnelian: consq.decrease 1
        sealboneTrinket: consq.increase 1

    return
