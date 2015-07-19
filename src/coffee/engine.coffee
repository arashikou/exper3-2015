angular.module 'qbn.engine', ['qbn.quality', 'qbn.storylet', 'qbn.choice']

  .filter 'resolve', ($injector, qualities) ->
    (v) ->
      while typeof v == 'function' || Array.isArray v
        qualityNames = $injector.annotate v
        qualityValues = qualityNames.map (name) -> qualities.lookup(name)?.value
        v = v qualityValues...
      return v

  .controller 'QbnEngine',
    ($scope, qualities, storylets, frontalChoices, choiceFactory, resolveFilter) ->
      $scope.qualities = qualities.getAll()

      updateFrontalChoices = () ->
        $scope.choices = frontalChoices.getAll()
        return
      updateFrontalChoices()

      retreat = choiceFactory '!!retreat!!',
        'On second thought, maybe not…'
        'Return to the previous screen.'
        {}, {}, undefined

      onwards = choiceFactory '!!onwards!!',
        'The story continues…'
        '', {}, {}, undefined

      $scope.choose = (choice) ->
        next = resolveFilter choice.next
        storylet = storylets.lookup next
        if storylet?
          unless $scope.storylet?
            storylet.choices = storylet.choices.concat retreat
          unless storylet.choices?
            storylet.choices = [onwards]
        else
          updateFrontalChoices()
        $scope.storylet = storylet
        return
      return
