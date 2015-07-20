angular.module 'qbn.edsl', ['qbn.quality', 'qbn.storylet', 'qbn.choice']
  .factory 'qbnEdsl', (qualities, storylets, frontalChoices, choiceFactory) ->
    api =
      qualityType: Object.freeze
        stat: () -> "#{@name} is #{@value}"
        item: () -> "#{@value} x #{@name}"
        unique: () -> "You have #{@name}"
        string: () -> "You are #{@value}"
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

      storylet: (id, title, text, args = {}) ->
        {choices, consequences} = args
        choices ?= []
        consequences ?= {}
        storylets.register id, title, text, choices, consequences
        return
      consq: Object.freeze
        increase: (amount) ->
          (quality) ->
            changedBy = quality.increase amount
            if not changedBy?
              "#{quality.name} increased by #{amount}."
            else if changedBy == 0
              "#{quality.name} progressed by #{amount}. Only #{quality.maxProgress - quality.progress} to go!"
            else
              "#{quality.name} progressed by #{amount}, increasing it to #{quality.value}! Only #{quality.maxProgress - quality.progress} to go."
        decrease: (amount) ->
          (quality) ->
            changedBy = quality.increase -amount
            if not changedBy?
              "#{quality.name} decreased by #{amount}."
            else if changedBy == 0
              "#{quality.name} regressed by #{amount}. Now there's #{quality.maxProgress - quality.progress} to go!"
            else
              "#{quality.name} regressed by #{amount}, reducing it to #{quality.value}! Now there's #{quality.maxProgress - quality.progress} to go."

      choice: (id, title, text, args = {}) ->
        {next, visible, active} = args
        next ?= id
        visible ?= {}
        active ?= {}
        choiceFactory id, title, text, visible, active, next
      front: (choice) ->
        frontalChoices.register choice
        return
      retreat: (choice) ->
        frontalChoices.setRetreat choice
        return
      onwards: (choice) ->
        frontalChoices.setOnwards choice
        return
      reqs: Object.freeze
        gt: (req) ->
          (quality) -> (quality.value > req) ||
            "Requires #{quality.name} greater than #{req}. You have #{quality.value}."
        lt: (req) ->
          (quality) -> (quality.value < req) ||
            "Requires #{quality.name} less than #{req}. You have #{quality.value}."
        range: (low, high) ->
          (quality) -> (low < quality.value < high) ||
            "Requires #{quality.name} between #{low} and #{high}. You have #{quality.value}."
        exists:
          (quality) -> if quality.value then true else
            "Requires #{quality.name}, which you do not have."
    return Object.freeze api
