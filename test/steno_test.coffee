assert = require 'assertive'
bond = require 'bondjs'
fs = require 'fs'
Steno = require '../lib/steno'

describe 'Steno', ->
  it 'exists', ->
    assert.expect new Steno

  describe '#constructor', ->
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

  describe '#findFiles', ->
    it 'returns an empty array on error', ->
      bond(fs, 'readdir').asyncReturn 'foo'
      s = new Steno

      s.findFiles (err, files, stats) ->
        assert.equal 'foo', err
        assert.deepEqual [], files

    describe 'prefix filtering', ->
      beforeEach ->
        @s = new Steno prefix: 'test'
        bond(fs, 'readdir').asyncReturn null, ['a file.txt', 'test file.txt', 'not a test file.txt']

      it 'returns only files matching the specified prefix', ->
        @s.findFiles (err, files, stats) ->
          assert.equal 1, files.length
          assert.equal 'test file.txt', files[0]

      it 'returns information on files found, before and after filtering', ->
        @s.findFiles (err, files, stats) ->
          assert.equal 3, stats.beforeFilter
          assert.equal 1, stats.afterFilter

    describe 'filetype filtering', ->
      beforeEach ->
        @s = new Steno filetype: 'md'
        bond(fs, 'readdir').asyncReturn null, ['confidential.md', 'secret.txt', 'secret.md', 'secret.xls']

      it 'returns only files matching the specified filetype', ->
        @s.findFiles (err, files, stats) ->
          assert.equal 2, files.length
          assert.equal 'confidential.md', files[0]
          assert.equal 'secret.md', files[1]

      it 'returns information on files found, before and after filtering', ->
        @s.findFiles (err, files, stats) ->
          assert.equal 4, stats.beforeFilter
          assert.equal 2, stats.afterFilter
