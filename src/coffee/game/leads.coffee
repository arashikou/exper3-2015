angular.module 'gameDefinition.leadStories', ['qbn.edsl', 'gameDefinition.enums']
  .run (qbnEdsl, enums) ->
    {storylet, choice, reqs, consq} = qbnEdsl
    {leads} = enums

    storylet 'storylines',
      'Track down a lead'
      '''
      You sit down at your desk and pool all your possible leads. Someone out there has to
      know something about what happened. The question is: Who?

      _If you successfully start a lead, you will be committed to that lead and unable to follow up
      any others until you see your current lead through._
      '''
      choices: [
        choice 'jackieStart',
          'Jackie, old-school detective'
          'Mr. Brown hired Jackie to do something. What? And why?'
          visible:
            jackie: reqs.eq 1
        choice 'roxyStart',
          'Roxy Malone, big-time gangster'
          'Roxy is trying to intimidate Mrs. Brown. But why?'
          visible:
            roxyThugDescription: reqs.gte 1
          active:
            keyOfDreams: reqs.exists
        choice 'employerStart',
          'Mr. Brown\'s last employer'
          '''
          Mr. Brown was doing work for hire for the offices of Kimble, Battherwhite, and Smith when
          he disappeared.
          Someone there might know something.
          '''
          visible:
            kbs: reqs.eq 0
          active:
            rumor: reqs.gte 10
        choice 'clubEntry',
          'The Salamander Club'
          '''
          Ever since you lost your magical abilities, you've lost touch with the magical community
          in the city.
          The Salamander Club is a favorite watering hole of the sorcerous set and your best bet to
          make contact with anyone who might know Mr. Brown.
          '''
          active:
            cantripUp: reqs.gte 6
        choice 'pressStart',
          'The press'
          '''
          The disappearance of someone as high-profile as Horace Brown should be all over the news.
          But Mrs. Brown was the first you heard of it. Who's keeping the papers quiet? Maybe one
          of your contacts knows.
          '''
          active:
            keyOfDreams: reqs.exists
        choice 'copStart',
          'A crooked cop'
          '''
          Officer Dentley is a lousy cop, but a great informant. For the right fee, he'll tell you
          everything the police know about anything.
          '''
          visible:
            cop: reqs.eq 0
          active:
            bluebacks: reqs.gte 10
      ]

    ## The Salamander Club
    storylet 'clubEntry',
      'The Salamander Club'
      '''
      Downing an entire case of Cantrip-Up won't restore your magic in any way, but it will give you
      enough of a glow to trick the bouncer into letting you in.

      Once inside, you take up a position in the corner closest to the kitchen and watch the
      crowd. There are countless magical types in here, but do any catch your eye?
      '''
      consequences:
        cantripUp: consq.decrease 6
      choices: [
        choice 'clubStudent',
          'A nervous-looking student'
          '''
          She looks liable to explode at any second. Whether literally or figuratively, you're not
          sure.
          '''
          visible:
            student: reqs.eq 0
        choice 'clubDealer',
          'A dealer in rarities'
          'He\'s doing a brisk trade from his booth.'
          visible:
            dealer: reqs.notexists
          active:
            cagedDemon: reqs.gte 1
        choice 'clubQuit',
          'Cut your losses'
          '''
          This sounded like a better plan before you drank all that Cantrip-Up.

          _This will allow you to leave and restore some, but not all, of the resources you expended
          to get in here._
          '''
      ]

    storylet 'clubQuit',
      'Cut your losses'
      '''
      You slip through the kitchen on your way out and grab a nearly-full case of Cantrip-Up.
      They probably won't miss it.
      '''
      consequences:
        cantripUp: consq.increase 5

    return
