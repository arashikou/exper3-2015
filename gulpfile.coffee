gulp       = require 'gulp'
del        = require 'del'
haml       = require 'gulp-haml'
sourcemaps = require 'gulp-sourcemaps'
coffee     = require 'gulp-coffee'
serve      = require './serve.coffee'

SRC = 'src'
DEST = 'out'

gulp.task 'default', ['haml', 'coffee']

gulp.task 'haml', ->
  gulp.src "#{SRC}/haml/**/*.haml"
    .pipe haml()
    .pipe gulp.dest DEST

gulp.task 'coffee', ->
  gulp.src "#{SRC}/coffee/**/*.coffee"
    .pipe sourcemaps.init()
    .pipe coffee()
    .pipe sourcemaps.write()
    .pipe gulp.dest "#{DEST}/scripts"

gulp.task 'clean', (callback) ->
  del DEST, callback

gulp.task 'serve', ->
  serve DEST
