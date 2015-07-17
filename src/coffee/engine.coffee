angular.module 'qbn.engine', ['qbn.quality', 'qbn.storylet']
  .controller 'QbnEngine', ($scope, qualities, storylets) ->
    $scope.qualities = qualities.getAll()
    return
