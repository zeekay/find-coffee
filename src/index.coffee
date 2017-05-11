version = (coffee) ->
  parseInt (coffee.VERSION.split '.')[0], 10

# Resolve specific version of CoffeeScript
resolveCoffee = (wanted) ->
  for pkg in ['coffeescript', 'coffee-script']
    try
      coffee = require.resolve pkg
      return coffee if (version coffee) == wanted
    catch err
  throw new Error 'Unable to find CoffeeScript matching version ' + wanted

export default findCoffee = (wanted, lazy=false) ->
  # Default to 2, but take accept 1
  unless wanted?
    try
      return findCoffee 2, lazy
    catch err
      return findCoffee 1, lazy

  pkg = resolveCoffee wanted

  if lazy
    pkg
  else
    require pkg
