angular.module 'qbn.engine', ['qbn.quality', 'qbn.storylet']
  .controller 'QbnEngine', ($scope, qualityLibrary, storyletLibrary) ->
    $scope.qualities = qualityLibrary.getAll()
    return
