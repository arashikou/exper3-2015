angular.module 'gameDefinition.introStories', ['qbn.edsl', 'gameDefinition.enums']
  .run (qbnEdsl, enums, qualities) ->
    {storylet, start, choice, front, retreat, onwards, reqs, consq} = qbnEdsl
    {leads, origins} = enums

    start 'lets-begin'

    storylet 'lets-begin',
      'It was a dark and stormy decade…'
      '''
      The years that followed the commoditization of sorcery were tumultous and difficult. People
      were faced with an ever-expanding array of new possibilities for their lives. The social
      order was shaken like an uptown Old Fashioned.

      There was, naturally, a war. You came out of it with a few interesting scars to share with
      those most intimate and one very uninteresting scar on your psyche that left you permanently
      unable to access the sorceric warpweave ever again. It was a shame, too. You'd had such a
      promising career before that, studying…

      Which branch of magic was it again?
      '''
      choices: [
        choice 'begin-illusion',
          'Illusion'
          'The magic of making one thing appear to be another thing.'
        choice 'begin-hallucination',
          'Hallucination'
          'The magic of making things appear to exist which do not.'
        choice 'begin-hypnotism',
          'Hypnotism'
          'The magic of making people believe things they do not.'
      ]

    beginSnippet =
      '''
      Yes, that was it.

      Anyway, that's all over now. The war left you without a scrap of magic
      to your name, just a strange itch whenever you're in the presence of your old field of work.

      But you, you were enterprising. You parleyed that subliminal itch, that instinct about magic,
      into a career as a detective. When people have problems that seem magical in nature, they come
      to you. You are The Disillusionist.
      '''
    beginChoice =
      choice 'begin-case',
        'Tell me about my latest case'

    storylet 'begin-illusion',
      'Ah, Illusion'
      beginSnippet
      consequences:
        origin: consq.set origins.illusionist
        illusionHunch: consq.increase 1
      choices: [beginChoice]

    storylet 'begin-hallucination',
      'Ah, Hallucination'
      beginSnippet
      consequences:
        origin: consq.set origins.hallucinist
        hallucinationHunch: consq.increase 1
      choices: [beginChoice]

    storylet 'begin-hypnotism',
      'Ah, Hypnotism'
      beginSnippet
      consequences:
        origin: consq.set origins.hypnotist
        hypnotismHunch: consq.increase 1
      choices: [beginChoice]

    storylet 'begin-case',
      'It was late on a Tuesday…'
      '''
      It was late on a Tuesday when Mrs. Abigail Brown walked into your office. Normally, when a
      lady that well-dressed sees fit to cross your door, there's infidelity behind it. It means
      long nights staking out a love nest in your future, waiting for Mr. Client to come dally with
      Not-Mrs. Client.

      But something was off. This wasn't the usual cheating-husband job. There was a tear to her
      eye before she even
      got in your door, not the mixture of determination and shame that eventually gave way to
      either sobbing or rage.

      Over the next forty-five minutes, you drew the whole story out of her. How she was the wife
      of famed sorcerer Horace Brown. How he had gone missing two weeks ago from a sealed parlor
      in their Silver Street home. How the police had dismissed the case with suspicious ease,
      insisting Mr.
      Brown must have simply had an accident with forces beyond his control. As if "Demon Eyes
      Brown" had ever met a force he could not match.

      You took the case in a heartbeat. This was not only the most interesting case to cross your
      desk since there was snow on the ground, but it stood to be the most lucrative in a long time,
      and the landlord was starting to resemble a hungry wolf more and more each day. Mrs. Brown
      paid the retainer for your first two days and didn't even haggle the rate.

      Now the only question was: Where to start looking?
      '''
      consequences:
        bluebacks: consq.increase 2
      choices: [
        choice 'returnForward',
          'The story continues…'
          '_Go to the main screen._'
          next: false
      ]

    return
