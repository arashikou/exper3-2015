angular.module 'gameDefinition.copStories', ['qbn.edsl', 'gameDefinition.enums']
  .run (qbnEdsl, enums) ->
    {storylet, choice, reqs, consq} = qbnEdsl
    {leads} = enums

    storylet 'copStart',
      'A crooked cop'
      '''
      Dentley thumbs the stack of bills to make sure you aren't shorting him. "Horace Brown, eh?
      Funny you should mention him. That name just came across my desk this morning."

      You ask whether this means the police are going to investigate the disappearance after all.

      "No, no, nothing like that. His _alleged_ disappearance…" Something gives even Dentley pause.
      "That investigation is being shut down from a very high level. No, he came up as a person of
      interest in another case. Of course, as no one can find him, that's a request I am putting
      no effort into fulfilling."

      "There was a body. Washed up on the south banks near the granary district. It also vanished
      before we could bring it in. I don't know any more than that, but someone thinks it's tied to
      Brown, somehow, so it's probably of interest to you."
      '''
      consequences:
        bluebacks: consq.decrease 10
        lead: consq.set leads.cop
        cop: (quality) ->
          quality.value++
          'Officer Dentley has given you a tip about a body.'
        progress: consq.set 0

    storylet 'cop1',
      'Follow up on Dentley\'s tip'
      '''
      You need to find this body before the police do.
      '''
      choices: [
        choice 'cop1Rumor',
          'Connect the dots'
          'Some of these rumors you\'re hearing must be about the body.'
          visible:
            progress: reqs.lt 7
          active:
            rumor: reqs.gte 3
        choice 'cop1Bluebacks',
          'Pay for info'
          'Unlike the police, you\'re willing to pay for good info.'
          visible:
            progress: reqs.lt 7
          active:
            bluebacks: reqs.gte 3
        choice 'cop1CantripUp',
          'Hire a scryer'
          'Magic is the modern way, after all.'
          visible:
            progress: reqs.lt 7
          active:
            cantripUp: reqs.gte 3
        choice 'cop1Solve',
          'Somebody has been found'
          'You know where the body went. You can only hope there\'s enough left to ID.'
          active:
            progress: reqs.gte 7
      ]

    storylet 'cop1Rumor',
      'Connect the dots'
      '''
      With your info, you are able to narrow down the locations the body could have gone to.
      '''
      consequences:
        rumor: consq.decrease 3
        progress: consq.increase 1

    storylet 'cop1Bluebacks',
      'Pay for info'
      '''
      You find a few people who saw the body before it was moved or saw it being moved. Whoever it
      was has them too scared to name names, but you can feel your net closing.
      '''
      consequences:
        bluebacks: consq.decrease 3
        progress: consq.increase 1

    storylet 'cop1CantripUp',
      'Hire a scryer'
      '''
      You can't afford a top-rate scryer, but the one you _can_ afford gives your some tantalizing
      and useful clues about the body's current disposition.
      '''
      consequences:
        cantripUp: consq.decrease 3
        progress: consq.increase 1

    storylet 'cop1Solve',
      'Not much left'
      '''
      You burst into the warehouse and order everyone on the floor. Like terrified lambs, they all
      comply. Despite their sick tendencies, these men and women aren't savage or prepared to
      defend themselves. They're lucky you found them and their crime first; the police might
      have come in with guns blazing.

      They're "ghouls," or at least that's how they fancy themselves. People who think this era of
      casual magic gives them the right to appropriate old cultural traditions and use them as a
      cover for their twisted desires.

      You gather what's left of the body in a sack and warn them to get lost before the police
      arrive. You make haste to the precinct before the body starts to smell, but not before taking
      a peek for yourself.

      There's not much left, but what's there is confusing. The body is female, unqestionably.
      There are bits of clothing from a dress similar to the one
      Mrs. Brown was wearing the day she walked into your office. Also a broach that's identical
      to one you've seen at the Brown household. And judging by the time of its discovery and its
      state at the time, this person probably died within a day before or after Mr. Brown
      disappearing. There's no hope of identifying this person now, but
      this is definitely tied to your case somehow.
      '''
      consequences:
        evidence: consq.increase 2
        lead: (quality) ->
          quality.value = undefined
          'Your current lead has ended.'
        cop: (quality) ->
          quality.value++
          'You found a body, or at least what\'s left of it.'
        progress: consq.set 0

    return
