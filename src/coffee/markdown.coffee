converter = new window.showdown.Converter
  strikethrough: true

angular.module 'markdown', []
  .filter 'markdown', () ->
    (input) -> converter.makeHtml input ? ''
