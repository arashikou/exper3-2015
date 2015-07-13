gulp = require 'gulp'
del  = require 'del'
haml = require 'gulp-haml'

gulp.task 'default', ['haml']

gulp.task 'haml', ->
  gulp.src 'src/haml/**/*.haml'
    .pipe haml compiler: 'visionmedia'
    .pipe gulp.dest 'out'

gulp.task 'clean', (callback) ->
  del 'out', callback
