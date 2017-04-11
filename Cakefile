use 'sake-bundle'
use 'sake-outdated'
use 'sake-publish'
use 'sake-version'
use 'sake-test'

task 'clean', 'clean project', ->
  exec 'rm -rf lib'

task 'build', 'build project', ->
  bundle.write
    entry: 'src/index.coffee'
    compilers:
      coffee:
        version: 1

task 'watch', 'watch project and build on changes', ->
  build = (filename) ->
    console.log filename, 'modified, rebuilding'
    invoke 'build' if not running 'build'
  watch 'src/',          build
  watch 'node_modules/', build, watchSymlink: true

task 'test', 'test project', ['build']
