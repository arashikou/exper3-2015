angular.module 'qbn.edsl', ['qbn.quality', 'qbn.storylet', 'qbn.choice']
  .factory 'qbnEdsl', (qualities, storylets, frontalChoices, choiceFactory) ->
    api =
      qualityType: Object.freeze
        stat: () -> "#{@name} is #{@value}"
        item: () -> "#{@value} x #{@name}"
        unique: () -> "You have #{@name}"
      quality: (id, type, name, description, args = {}) ->
        {value, progress, maxProgress, hasProgress, escalation, visible} = args
        value ?= 0
        progress ?= 0
        maxProgress ?= if hasProgress then 100 else 0
        escalation ?= 0.10
        visible ?= true
        qualities.register id, name, type, description, value,
                           progress, maxProgress, escalation,
                           visible
        return

      storylet: (id, title, text, choices...) ->
        storylets.register id, title, text, choices
        return

      choice: (id, title, text, args = {}) ->
        {next, visible, active} = args
        next ?= id
        visible ?= {}
        active ?= {}
        choiceFactory id, title, text, visible, active, next
      front: (choice) ->
        frontalChoices.register choice
        return
      reqs: Object.freeze
        gt: (req) ->
          (quality) -> (quality.value > req) || "Requires #{quality.name} greater than #{req}."
        lt: (req) ->
          (quality) -> (quality.value < req) || "Requires #{quality.name} less than #{req}."
        range: (low, high) ->
          (quality) -> (low < quality.value < high) || "Requires #{quality.name} between #{low} and #{high}."
        exists:
          (quality) -> if quality.value then true else "Requires #{quality.name}."
      increase: (qualityName, major, minor) ->
        quality = qualities.lookup(qualityName)
        if quality?
          hasProgress = quality.maxProgress != 0
          if hasProgress
            quality.increase(minor, major)
          else
            quality.increase(major, 0)
        return
    return Object.freeze api
