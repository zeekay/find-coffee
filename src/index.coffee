path = require 'path'

version = (coffeePath) ->
  pkg = require(path.resolve(coffeePath, '../../../package.json'))
  parseInt (pkg.version.split '.')[0], 10

# Resolve specific version of CoffeeScript
resolveCoffee = (wanted) ->
  for pkg in ['coffeescript', 'coffee-script']
    try
      coffeePath = require.resolve pkg
      return coffeePath if (version coffeePath) == wanted
    catch err
  throw new Error 'Unable to find CoffeeScript matching version ' + wanted

export default findCoffee = (wanted, lazy=false) ->
  # Default to 2, but take accept 1
  unless wanted?
    try
      return findCoffee 2, lazy
    catch err
      return findCoffee 1, lazy

  pkgPath = resolveCoffee wanted

  if lazy
    pkgPath
  else
    require pkgPath
