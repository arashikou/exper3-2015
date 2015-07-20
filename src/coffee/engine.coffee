angular.module 'qbn.engine', ['qbn.quality', 'qbn.storylet', 'qbn.choice', 'qbn.resolve']
  .controller 'QbnEngine',
    ($scope, qualities, storylets, frontalChoices, choiceFactory, resolveFilter) ->
      updateFrontalValues = () ->
        $scope.qualities = qualities.getAll()
        $scope.choices = frontalChoices.getAll()
        return
      updateFrontalValues()
      
      $scope.choose = (choice) ->
        next = resolveFilter choice.next
        storylet = storylets.lookup next
        if storylet?
          storylet.performConsequences()
          unless $scope.storylet?
            storylet.choices = storylet.choices.concat frontalChoices.getRetreat()
          unless storylet.choices.length > 0
            storylet.choices = [frontalChoices.getOnwards()]
        else
          updateFrontalValues()
        $scope.storylet = storylet
        return
      return
  .directive 'choiceList', () ->
    templateUrl: 'choiceList'
    restrict: 'E'
    scope:
      choices: '='
      choose: '='
