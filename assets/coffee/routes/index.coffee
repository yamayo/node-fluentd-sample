'use strict'

###
Module dependencies.
###

exports.index = (req, res, next) ->
  next new Error('Fluentd test')
