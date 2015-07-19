angular.module 'qbn.engine', ['qbn.quality', 'qbn.storylet', 'qbn.choice', 'qbn.resolve']
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
          unless storylet.choices.length > 0
            storylet.choices = [onwards]
        else
          updateFrontalChoices()
        $scope.storylet = storylet
        return
      return
