gulp        = require 'gulp'
del         = require 'del'
deleteLines = require 'gulp-delete-lines'
jade        = require 'gulp-jade'
replace     = require 'gulp-replace'
sourcemaps  = require 'gulp-sourcemaps'
less        = require 'gulp-less'
prefixer    = require 'gulp-autoprefixer'
minifyCss   = require 'gulp-minify-css'
coffee      = require 'gulp-coffee'
wrap        = require 'gulp-wrap-js'
uglify      = require 'gulp-uglify'
concat      = require 'gulp-concat'
serve       = require './serve.coffee'

SRC = 'src'
DEST = 'out'
RELEASE_DEST = 'release'
pathTo = (ext) -> "#{SRC}/#{ext}/**/*.#{ext}"
JADE_PATH = pathTo 'jade'
LESS_PATH = pathTo 'less'
COFFEE_PATH = pathTo 'coffee'

gulp.task 'build', ['jade', 'less', 'coffee']

gulp.task 'jade', ->
  packageJson = require './package.json'
  gulp.src JADE_PATH
    .pipe deleteLines filters: [/^doctype/]
    .pipe replace '##VERSION##', packageJson.version
    .pipe jade
      doctype: 'html'
      pretty: false
    .pipe gulp.dest RELEASE_DEST
    .pipe gulp.dest DEST

gulp.task 'less', ->
  gulp.src LESS_PATH
    .pipe sourcemaps.init()
    .pipe less()
    .pipe prefixer browsers: [
      'last 2 Chrome versions'
      'last 2 Firefox versions'
      'last 2 Explorer versions'
      'last 2 Safari versions'
    ]
    .pipe concat 'qbn.css'
    .pipe minifyCss()
    .pipe gulp.dest "#{RELEASE_DEST}/styles"
    .pipe sourcemaps.write()
    .pipe gulp.dest "#{DEST}/styles"

gulp.task 'coffee', ->
  gulp.src COFFEE_PATH
    .pipe sourcemaps.init()
    .pipe coffee()
    .pipe concat 'qbn.js'
    .pipe wrap '"use strict";{%= body %}'
    #.pipe uglify mangle: false
    .pipe gulp.dest "#{RELEASE_DEST}/scripts"
    .pipe sourcemaps.write()
    .pipe gulp.dest "#{DEST}/scripts"

gulp.task 'clean', (callback) ->
  del [DEST, RELEASE_DEST], callback

gulp.task 'watch', ['build'], ->
  gulp.watch JADE_PATH, ['jade']
  gulp.watch LESS_PATH, ['less']
  gulp.watch COFFEE_PATH, ['coffee']
  return

gulp.task 'serve', ->
  serve DEST

gulp.task 'default', ['watch', 'serve']
