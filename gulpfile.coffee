gulp = require 'gulp'
del  = require 'del'

gulp.task 'default', ->
  gulp.src 'src/**'
    .pipe gulp.dest 'out'

gulp.task 'clean', (callback) ->
  del 'out', callback
