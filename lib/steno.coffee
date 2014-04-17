class Steno
  constructor: (options={}) ->
    @directory = options.directory || options.d
    @prefix = options.prefix || options.p || ''
    @filetype = options.filetype || options.f || 'txt'


module.exports = Steno
