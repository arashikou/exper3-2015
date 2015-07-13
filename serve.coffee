connect     = require 'connect'
serveStatic = require 'serve-static'

module.exports = (root) ->
  app = connect()
  app.use serveStatic root
  app.listen 8080
