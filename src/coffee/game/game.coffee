angular.module 'gameDefinition', [
  'qbn.edsl'
  'gameDefinition.enums'
  'gameDefinition.qualities'
  'gameDefinition.frontChoices'
  'gameDefinition.introStories'
  'gameDefinition.restStories'
  'gameDefinition.straightTradeStories'
  'gameDefinition.clientStories'
  'gameDefinition.leadStories'
  'gameDefinition.jackieStories'
]
  .run (qbnEdsl, enums) ->
    {storylet, start, choice, front, retreat, onwards, reqs, consq} = qbnEdsl
    {leads, origins} = enums

    retreat choice 'retreat',
      'On second thought, maybe not…'
      '_Return to the main screen._'
      next: false

    onwards choice 'onwards',
      'The story continues…'
      '_Return to the main screen._'
      next: false

    return
