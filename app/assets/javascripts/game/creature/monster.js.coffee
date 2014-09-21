#= require ./base
class gameApp.Creature.Monster extends gameApp.Creature.Base
  initialize: (name, spritesheet, parent) ->
    @parent = parent
    @name = name
    @id = _.uniqueId(name)
    @spritesheet = spritesheet
    @action = "attack"
    @direction = "left"
    @view = "back"
    @xPosition = _.random(0, parent.gameScreen.clientWidth)
    @yPosition = _.random(0, parent.gameScreen.clientHeight)
    @animations = spritesheet.animations
    @frameIndex = 0
    @frame
    @isWalking = false
    @hasDestination = false
    @xDestination
    @yDestination
    @moveSpeed = 1
    @_do_ai = parent._global_do_ai 
    return
    
  setDestination: (x, y) ->
    if @_do_ai
      @yDestination = y
      @xDestination = x

  update: ->
    @setAction()
    if @_do_ai
      @hasDestination = false
      @_ai()
    else
      @randomWalk()
    @draw()
    return

  destroy: ->
    #something
  
  frameToUse: ->
    return "walking" + @direction

  draw: ->
    current_animation = @animations[@action][@view][@direction]
    if current_animation?
      if @parent.timer % 4 is 0
        @frameIndex++
        @frameIndex = 0  if @frameIndex > (current_animation.length - 1)
  
      @frame = current_animation[@frameIndex]
      if @frame?
        @parent.context.drawImage @frame, @xPosition, @yPosition
    return

  randomWalk: ->
    @hasDestination = false if @xPosition is @xDestination and @yPosition is @yDestination
    if @hasDestination
      @_ai()
    else
      @xDestination = Math.floor(Math.random() * $(window).width() )
      @yDestination = Math.floor(Math.random() * $(window).height() )
      @hasDestination = true
    return

  calculateNextPosition: ->
    if @xPosition > @xDestination
      @direction = 'left'
      @xPosition -= @moveSpeed

    if @xPosition < @xDestination
      @direction = 'right'
      @xPosition += @moveSpeed

    if @yPosition > @yDestination
      @view = 'back'
      @yPosition -= @moveSpeed

    if @yPosition < @yDestination
      @view = 'front'
      @yPosition += @moveSpeed

  _is_attacking: false
  _attacking_time: 60
  _attacking_counter: 0

  toggleAttack: =>
    @_is_attacking = (not @_is_attacking)
    if @_is_attacking
      if @atk?
        clearInterval(@atk)
        @atk = undefined
      @_attacking_counter = 0
      @action = 'attack'

  setToAttackIn: (interval) ->
    if not @atk?
      @atk = setInterval(@toggleAttack, interval)
      
  setAction: ->
    @action = if @xPosition is @xDestination and @yPosition is @yDestination
      if @_is_attacking
        'attack'
      else
        'idle'
    else
      'walk'

  _ai: ->
    if @action is 'walk'
      @calculateNextPosition()
    else if @action is 'idle'
      @setToAttackIn(100)
    else if @action is 'attack'
      @calculateNextPosition()
      @_attacking_counter++
      if @_attacking_counter >= @_attacking_time
        @toggleAttack()
        @action = 'walk'




