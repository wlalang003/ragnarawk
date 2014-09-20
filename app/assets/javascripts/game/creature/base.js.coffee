class gameApp.Creature.Base
  # setup creature base properties
  constructor: (properties = {}) ->
    _.extend(@, _.omit(properties,'constructor'))
    @initialize?.apply(@, arguments)
    
  
