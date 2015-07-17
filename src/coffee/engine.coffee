angular.module 'qbn.engine', ['qbn.quality', 'qbn.storylet']
  .controller 'QbnEngine', ($scope, qualityLibrary, storyletLibrary) ->
    qualities = {}
    return
