angular.module 'qbn.engine', ['qbn.quality', 'qbn.storylet', 'qbn.choice']
  .controller 'QbnEngine', ($scope, qualities, storylets, frontalChoices) ->
    $scope.qualities = qualities.getAll()
    $scope.choices = frontalChoices.getAll()
    return
