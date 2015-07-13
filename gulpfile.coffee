gulp   = require 'gulp'
del    = require 'del'
haml   = require 'gulp-haml'
coffee = require 'gulp-coffee'

gulp.task 'default', ['haml', 'coffee']

gulp.task 'haml', ->
  gulp.src 'src/haml/**/*.haml'
    .pipe haml compiler: 'visionmedia'
    .pipe gulp.dest 'out'

gulp.task 'coffee', ->
  gulp.src 'src/coffee/**/*.coffee'
    .pipe coffee()
    .pipe gulp.dest 'out/scripts'

gulp.task 'clean', (callback) ->
  del 'out', callback
