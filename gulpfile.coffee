gulp       = require 'gulp'
del        = require 'del'
haml       = require 'gulp-haml'
sourcemaps = require 'gulp-sourcemaps'
coffee     = require 'gulp-coffee'
serve      = require './serve.coffee'
bower      = require 'main-bower-files'

SRC = 'src'
DEST = 'out'

gulp.task 'default', ['haml', 'coffee', 'bower']

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

gulp.task 'bower', ->
  gulp.src bower()
    .pipe gulp.dest "#{DEST}/scripts/external"

gulp.task 'clean', (callback) ->
  del DEST, callback

gulp.task 'serve', ->
  serve DEST
