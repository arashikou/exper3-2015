gulp       = require 'gulp'
del        = require 'del'
haml       = require 'gulp-haml'
sourcemaps = require 'gulp-sourcemaps'
coffee     = require 'gulp-coffee'
serve      = require './serve.coffee'
bower      = require 'main-bower-files'

SRC = 'src'
DEST = 'out'
HAML_PATH = "#{SRC}/haml/**/*.haml"
COFFEE_PATH = "#{SRC}/coffee/**/*.coffee"

gulp.task 'build', ['haml', 'coffee', 'bower']

gulp.task 'haml', ->
  gulp.src HAML_PATH
    .pipe haml()
    .pipe gulp.dest DEST

gulp.task 'coffee', ->
  gulp.src COFFEE_PATH
    .pipe sourcemaps.init()
    .pipe coffee()
    .pipe sourcemaps.write()
    .pipe gulp.dest "#{DEST}/scripts"

gulp.task 'bower', ->
  gulp.src bower()
    .pipe gulp.dest "#{DEST}/external"

gulp.task 'clean', (callback) ->
  del DEST, callback

gulp.task 'watch', ['build'], ->
  gulp.watch HAML_PATH, ['haml']
  gulp.watch COFFEE_PATH, ['coffee']
  return

gulp.task 'serve', ->
  serve DEST

gulp.task 'default', ['watch', 'serve']
