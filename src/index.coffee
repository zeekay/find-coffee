import path     from 'path'
import {isBool} from 'es-is'

# Check version of coffee found
version = (coffeePath) ->
  pkg = require(path.resolve(coffeePath, '../../../package.json'))
  parseInt (pkg.version.split '.')[0], 10

# Resolve specific version of coffee, matching either package name
resolveCoffee = (wanted) ->
  pkgs = '''
    coffeescript
    coffee-script
    @zeekay/coffeescript
    @zeekay/coffee-script
    '''.trim().split '\n'

  for pkg in pkgs
    try
      coffeePath = require.resolve pkg
      return coffeePath if (version coffeePath) == wanted
    catch err
  throw new Error 'Unable to find CoffeeScript matching version ' + wanted

# Find and return coffee version, or alternately just path
export default findCoffee = (wanted, lazy) ->
  if isBool wanted
    [wanted, lazy] = [lazy, wanted]

  # Default to 2, but take accept 1
  unless wanted? or wanted == 'any'
    try
      return findCoffee 2, lazy
    catch err
      return findCoffee 1, lazy

  # Resolve path to package
  pkgPath = resolveCoffee wanted

  # If lazy only return path
  if lazy
    pkgPath
  else
    require pkgPath
