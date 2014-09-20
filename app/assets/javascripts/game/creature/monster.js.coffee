#= require ./base
class gameApp.Creature.Monster extends gameApp.Creature.Base
  initialize: (name, spritesheet, parent) ->
    @parent = parent
    @name = name
    @spritesheet = spritesheet
    @action = "attack"
    @direction = "left"
    @view = "back"
    @xPosition = 400
    @yPosition = 200
    @animations = spritesheet.animations
    @frameIndex = 0
    @frame
    @isWalking = false
    @hasDestination = false
    @xDestination
    @yDestination
    @moveSpeed = 1

    parent.gameScreen.onmousemove = (ev) =>
      #console.log ev
      @yDestination = ev.y
      @xDestination = ev.x

    return

  update: ->
    #@getDirection()
    #@_ai()
    @draw()
    return

  destroy: ->
    #something

  getDirection: ->
    if @xPosition > @xDestination and @yPosition <= @yDestination
      @direction = "FrontLeft"
    else if @xPosition < @xDestination and @yPosition <= @yDestination
      @direction = "FrontRight"
    else if @xPosition > @xDestination and @yPosition >= @yDestination
      @direction = "BackLeft"
    else if @xPosition < @xDestination and @yPosition >= @yDestination
      @direction = "BackRight"

  frameToUse: ->
    return "walking" + @direction

  draw: ->
    current_animation = @animations[@action][@view][@direction]
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
      @calculateNextPosition()
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
  _attacking_time: 300
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

  _ai: ->
    @action = if @xPosition is @xDestination and @yPosition is @yDestination
      if @_is_attacking
        'attack'
      else
        'idle'
    else
      'walk'
    if @action is 'walk'
      @calculateNextPosition()
    else if @action is 'idle'
      @setToAttackIn(100)
    else if @action is 'attack'
      @calculateNextPosition()
      @_attacking_counter++
      if @_attacking_counter >= @_attacking_time
        @action = 'walk'




