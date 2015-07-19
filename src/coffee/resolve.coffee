angular.module 'qbn.resolve', ['qbn.quality']
  .filter 'resolve', ($injector, qualities) ->
    (v) ->
      while typeof v == 'function' || Array.isArray v
        qualityNames = $injector.annotate v
        qualityValues = qualityNames.map (name) -> qualities.lookup(name)?.value
        v = v qualityValues...
      return v
