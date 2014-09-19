class gameApp.Monster
  constructor: (name, spritesheet, parent) ->
    @parent = parent
    @name = name
    @spritesheet = spritesheet
    @action = "idle"
    @xPosition = 20
    @yPosition = 20
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
    @randomWalk()
    @draw()
    return

  destroy: ->
    #something

  draw: ->
    if @parent.timer % 5 is 0
      @frameIndex++
      @frameIndex = 0  if @frameIndex > 7
    @frame = @animations["walkingFront"][@frameIndex]  if @action is "idle"
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
      @yDestination = Math.floor(Math.random() * $(window).h() )
      @hasDestination = true
    return

