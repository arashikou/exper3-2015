angular.module 'qbn.engine', ['qbn.quality', 'qbn.storylet', 'qbn.choice']
  .controller 'QbnEngine', ($scope, qualities, storylets, frontalChoices, choiceFactory) ->
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
      storylet = storylets.resolve choice.next
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
