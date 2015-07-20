angular.module 'qbn.save', ['qbn.quality']
  .factory 'savedGame', (qualities) ->
    storageName = 'qbnSave'
    api =
      load: () ->
        save = JSON.parse localStorage.getItem storageName
        if save?
          for savedQuality in save.qualities
            quality = qualities.lookup savedQuality.id
            quality.load savedQuality
        return [save?.storylet?.id, save?.storylet?.isFrontal]
      save: (storylet, isFrontal) ->
        save =
          qualities: qualities.saveAll()
        if storylet?
          save.storylet =
            id: storylet
            isFrontal: isFrontal
        localStorage.setItem storageName, JSON.stringify save
        return
    return Object.freeze api
