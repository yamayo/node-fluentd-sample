'use strict'

###
Module dependencies.
###

express = require 'express'
routes = require './routes'
path = require 'path'

logger = require 'fluent-logger'
logger.configure 'mongo', {host: 'localhost', port: 24224}

app = express()

app.configure ->
  app.set 'port', process.env.PORT or 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger 'dev'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static path.join(__dirname, 'public')
  app.use (err, req, res, next) ->
    logger.emit 'test', {error: err.message}
    res.render 'error', {status: 500, title: '500 Internal Server Error', err: err}

app.get '/', routes.index

app.listen process.env.PORT || 3000,  ->
  console.log 'Express server listening on port ' + app.get 'port'

