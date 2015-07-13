gulp       = require 'gulp'
del        = require 'del'
jade       = require 'gulp-jade'
sourcemaps = require 'gulp-sourcemaps'
coffee     = require 'gulp-coffee'
serve      = require './serve.coffee'

SRC = 'src'
DEST = 'out'
pathTo = (ext) -> "#{SRC}/#{ext}/**/*.#{ext}"
JADE_PATH = pathTo 'jade'
COFFEE_PATH = pathTo 'coffee'

gulp.task 'build', ['jade', 'coffee']

gulp.task 'jade', ->
  gulp.src JADE_PATH
    .pipe jade
      doctype: 'html'
      pretty: false
    .pipe gulp.dest DEST

gulp.task 'coffee', ->
  gulp.src COFFEE_PATH
    .pipe sourcemaps.init()
    .pipe coffee()
    .pipe sourcemaps.write()
    .pipe gulp.dest "#{DEST}/scripts"

gulp.task 'clean', (callback) ->
  del DEST, callback

gulp.task 'watch', ['build'], ->
  gulp.watch JADE_PATH, ['jade']
  gulp.watch COFFEE_PATH, ['coffee']
  return

gulp.task 'serve', ->
  serve DEST

gulp.task 'default', ['watch', 'serve']
