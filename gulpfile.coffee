gulp        = require 'gulp'
del         = require 'del'
deleteLines = require 'gulp-delete-lines'
jade        = require 'gulp-jade'
sourcemaps  = require 'gulp-sourcemaps'
less        = require 'gulp-less'
coffee      = require 'gulp-coffee'
uglify      = require 'gulp-uglify'
concat      = require 'gulp-concat'
serve       = require './serve.coffee'

SRC = 'src'
DEST = 'out'
pathTo = (ext) -> "#{SRC}/#{ext}/**/*.#{ext}"
JADE_PATH = pathTo 'jade'
LESS_PATH = pathTo 'less'
COFFEE_PATH = pathTo 'coffee'

gulp.task 'build', ['jade', 'coffee']

gulp.task 'jade', ->
  gulp.src JADE_PATH
    .pipe deleteLines filters: [/^doctype/]
    .pipe jade
      doctype: 'html'
      pretty: false
    .pipe gulp.dest DEST

gulp.task 'less', ->
  gulp.src LESS_PATH
    .pipe less()
    .pipe gulp.dest "#{DEST}/styles"

gulp.task 'coffee', ->
  gulp.src COFFEE_PATH
    .pipe sourcemaps.init()
    .pipe coffee()
    .pipe uglify mangle: false
    .pipe concat 'app.js'
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
