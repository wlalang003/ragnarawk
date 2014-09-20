#= require ./base
class gameApp.Creature.Monster extends gameApp.Creature.Base
  initialize: (name, spritesheet, parent) ->
    @parent = parent
    @name = name
    @spritesheet = spritesheet
    @action = "idle"
    @direction = "BackLeft"
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
    return

  update: ->
    @getDirection()
    @randomWalk()
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
    if @parent.timer % 4 is 0
      @frameIndex++
      @frameIndex = 0  if @frameIndex > (@animations[@frameToUse()].length - 1)

    @frame = @animations[@frameToUse()][@frameIndex]  if @action is "idle"
    @parent.context.drawImage @frame, @xPosition, @yPosition
    return

  randomWalk: ->
    @hasDestination = false  if Math.floor(Math.random() * 10) < 4  if @xPosition is @xDestination and @yPosition is @yDestination
    if @hasDestination
      @xPosition -= @moveSpeed  if @xPosition > @xDestination
      @xPosition += @moveSpeed  if @xPosition < @xDestination
      @yPosition -= @moveSpeed  if @yPosition > @yDestination
      @yPosition += @moveSpeed  if @yPosition < @yDestination
    else
      @xDestination = Math.floor(Math.random() * $(window).width() )
      @yDestination = Math.floor(Math.random() * $(window).height() )
      @hasDestination = true
    return

