assert = require 'assertive'
Steno = require '../lib/steno'

describe 'Steno', ->
  it 'exists', ->
    assert.expect new Steno

  describe 'arguments', ->
    describe 'directory', ->
      it 'accepts a --directory argument', ->
        s = new Steno directory: '/'
        assert.equal '/', s.directory

      it 'accepts a -d argument', ->
        s = new Steno d: '/var/log'
        assert.equal '/var/log', s.directory

    describe 'prefix', ->
      it 'accepts a --prefix argument', ->
        s = new Steno prefix: 'important'
        assert.equal 'important', s.prefix

      it 'accepts a -p argument', ->
        s = new Steno p: 'confidential'
        assert.equal 'confidential', s.prefix

      it 'defaults to a blank prefix', ->
        s = new Steno {}
        assert.equal '', s.prefix

    describe 'filetype', ->
      it 'accepts a --filetype argument', ->
        s = new Steno filetype: 'md'
        assert.equal 'md', s.filetype

      it 'accepts a -f argument', ->
        s = new Steno f: 'markdown'
        assert.equal 'markdown', s.filetype

      it 'defaults to a text files', ->
        s = new Steno {}
        assert.equal 'txt', s.filetype
