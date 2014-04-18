fs = require 'fs'
{filter} = require 'underscore'

class Steno
  constructor: (options={}) ->
    @directory = options.directory || options.d
    @prefix = options.prefix || options.p || ''
    @filetype = options.filetype || options.f || 'txt'

  findFiles: (cb) ->
    fs.readdir @directory, (err, files) =>
      return cb err, [], {} if err
      matchExpression = ///^#{@prefix}///
      matchingFiles = filter files, (filename) -> filename.match matchExpression
      cb null, matchingFiles, {beforeFilter: files.length, afterFilter: matchingFiles.length}

module.exports = Steno
