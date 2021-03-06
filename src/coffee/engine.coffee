angular.module 'qbn.engine', ['qbn.quality', 'qbn.storylet', 'qbn.choice', 'qbn.save',  'qbn.resolve']
  .factory 'startingPoint', () ->
    startingStorylet = undefined
    api =
      set: (value) -> startingStorylet = value
      get: () -> startingStorylet
    return Object.freeze api
  .controller 'QbnEngine',
    ($scope, startingPoint, qualities, storylets, frontalChoices, savedGame, resolveFilter) ->
      updateFrontalValues = () ->
        $scope.qualities = qualities.getAll()
        $scope.choices = frontalChoices.getAll()
        return

      addDefaultsToChoices = (storylet) ->
        if storylet.isFrontal
          storylet.choices = storylet.choices.concat frontalChoices.getRetreat()
        unless storylet.choices.length > 0
          storylet.choices = [frontalChoices.getOnwards()]
        return

      loaded = savedGame.load()
      if loaded?
        [storyletName, isFrontal] = loaded
        $scope.storylet = storylets.lookup storyletName
        if $scope.storylet?
          $scope.storylet.isFrontal = isFrontal
          addDefaultsToChoices $scope.storylet
      else
        $scope.storylet = storylets.lookup startingPoint.get()

      updateFrontalValues()

      $scope.choose = (choice) ->
        next = resolveFilter choice.next
        storylet = storylets.lookup next
        if storylet?
          storylet.performConsequences()
          storylet.isFrontal = not $scope.storylet?
          addDefaultsToChoices storylet
        else
          updateFrontalValues()
        $scope.storylet = storylet
        savedGame.save(storylet?.id, storylet?.isFrontal)
        return

      $scope.resetSave = () ->
        if confirm 'This will erase all your progress and start you over from the beginning. Are you sure?'
          savedGame.erase()
          location.reload()
        return
      return
  .directive 'choiceList', () ->
    templateUrl: 'choiceList'
    restrict: 'E'
    scope:
      choices: '='
      choose: '='
