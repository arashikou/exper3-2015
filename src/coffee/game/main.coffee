angular.module 'gameDefinition', [
  'qbn.edsl'
  'gameDefinition.qualities'
  'gameDefinition.frontChoices'
  'gameDefinition.introStories'
  'gameDefinition.restStories'
  'gameDefinition.straightTradeStories'
  'gameDefinition.clientStories'
  'gameDefinition.leadStories'
  'gameDefinition.jackieStories'
  'gameDefinition.employerStories'
  'gameDefinition.copStories'
  'gameDefinition.studentStories'
  'gameDefinition.dealerStories'
  'gameDefinition.endingStories'
]
  .run (qbnEdsl) ->
    {choice, retreat, onwards} = qbnEdsl

    retreat choice 'retreat',
      'On second thought, maybe not…'
      '_Return to the main screen._'
      next: false

    onwards choice 'onwards',
      'The story continues…'
      '_Return to the main screen._'
      next: false

    return
