#= require ./monster
#= require ./sprite
#= require ./spritesheet_extractor
#= require_tree ./spritesheet_details

class gameApp.Main
  constructor: ->
    @gameScreen = document.getElementById("gameScreen")
    @linkSheet = document.getElementById("linkSheet")
    @context = @gameScreen.getContext("2d")
    @posX = 1
    @posY = 1
    @ctr = 1
    @spriteWidth = 120
    @spriteHeight = 130
    @linkWalkLeft = []
    @linkWalkRight = []
    @linkWalkUp = []
    @linkWalkDown = []
    @timer = 0
    @multiple = 4
    @moveSpeed = 10
    @monster_sprite = {
      poring: new gameApp.PoringSpritesheet("poringSheet", @)
      thanatos: new gameApp.ThanatosSpritesheet("thanatosSheet", @)

    }

    @monster_count = {
      poring: 5
      thanatos: 1
    }

    @monsters = {
      poring: []
      thanatos: []
    }
    @walkDirection = @linkWalkRight
    document.onkeydown = (event) =>
      keyPressed = String.fromCharCode(event.keyCode)
      console.log "keyPressed = " + keyPressed
      switch keyPressed
        when "D"
          @walkDirection = @linkWalkRight
          @posX += @moveSpeed
        when "A"
          @walkDirection = @linkWalkLeft
          @posX -= @moveSpeed
        when "W"
          @walkDirection = @linkWalkUp
          @posY -= @moveSpeed
        when "S"
          @walkDirection = @linkWalkDown
          @posY += @moveSpeed

    @extractSprites()

  start: ->
    setInterval(@draw, 1000 / 60)

  extractSprites: ->
    @ctr = 0

    while @ctr < 10
      @canvas2 = document.createElement("canvas")
      @canvas2.width = 120
      @canvas2.height = 130
      @context2 = @canvas2.getContext("2d")
      @context2.drawImage @linkSheet, 120 * @ctr, 910, 120, 130, 0, 0, 120, 130
      @linkWalkRight[@ctr] = @canvas2
      @ctr++
    @ctr = 0

    while @ctr < 10
      @canvas2 = document.createElement("canvas")
      @canvas2.width = 120
      @canvas2.height = 130
      @context2 = @canvas2.getContext("2d")
      @context2.drawImage @linkSheet, 120 * @ctr, 650, 120, 130, 0, 0, 120, 130
      @linkWalkLeft[@ctr] = @canvas2
      @ctr++
    @ctr = 0

    while @ctr < 10
      @canvas2 = document.createElement("canvas")
      @canvas2.width = 120
      @canvas2.height = 130
      @context2 = @canvas2.getContext("2d")
      @context2.drawImage @linkSheet, 120 * @ctr, 780, 120, 130, 0, 0, 120, 130
      @linkWalkUp[@ctr] = @canvas2
      @ctr++
    @ctr = 0

    while @ctr < 10
      @canvas2 = document.createElement("canvas")
      @canvas2.width = 120
      @canvas2.height = 130
      @context2 = @canvas2.getContext("2d")
      @context2.drawImage @linkSheet, 120 * @ctr, 520, 120, 130, 0, 0, 120, 130
      @linkWalkDown[@ctr] = @canvas2
      @ctr++
    return

  updateMonsters: ->
    # update or destroy a monster based on count
    _.each @monster_count, (v, k) =>
      if @monsters[k].length == @monster_count[k]
      else if @monsters[k].length > @monster_count[k]
        diff = @monsters[k].length - @monster_count[k]
        c = 0
        while c < diff
          @monsters[k].pop @monsters[k][c]
          c++
      else if @monsters[k].length < @monster_count[k]
        console.log k
        diff = @monster_count[k] - @monsters[k].length
        c = 0
        while c < diff
          por = new gameApp.Monster(k, @monster_sprite[k], @)
          @monsters[k].push(por)
          c++

    _.each @monsters, (v, k) =>
      _.each @monsters[k], (mon) =>
        mon.update()

  monster_spawn_multiple: 300

  incrementMonsters: ->
    _.each @monsters, (v, k) =>
      if @monster_count[k] < 100
        @monster_count[k]++

  draw: =>
    @context.clearRect 0, 0, @gameScreen.width, @gameScreen.height

    #ctx.drawImage(sprite, 0, tileIndex * spriteSize, spriteSize, spriteSize, tileX, tileY, spriteSize, spriteSize);
    #http://www.w3schools.com/tags/canvas_drawimage.asp
    #context.drawImage(linkSheet, 0, 910, 120, 130, 0, 0, 120, 130);
    if (@timer % @multiple) is 0
      @ctr++
      @ctr = 0  if @ctr is 10

    if (@timer % @monster_spawn_multiple) is 0
      @incrementMonsters()

    #context.drawImage(walkDirection[ctr], posX, posY);
    @updateMonsters()
    #console.log(poring.draw());
    @timer = -1  if @timer > 600
    @timer++
    return

jQuery ->
  $('#gameScreen').width(window.width)
  $('#gameScreen').height(window.height)
  gameApp.main = new gameApp.Main()

  gameApp.main.gameScreen.width = $(window).width() #document.width is obsolete
  gameApp.main.gameScreen.height = $(window).height() #document.height is obsolete

  gameApp.main.start()

