#= require ./creature/monster
#= require ./sprite
#= require_tree ./utilities
#= require_tree ./spritesheet_details

class gameApp.Main
  constructor: ->
    @posX = 1
    @posY = 1
    @timer = 0
    @multiple = 4
    @moveSpeed = 10
    @monster_sheet = {
      thanatos: new gameApp.ThanatosSpritesheet("poringSheet", @)
      poring: new gameApp.PoringSpritesheet("poringSheet", @)
    }
    @monster_count = {
      poring: 0
      thanatos: 1
    }

    @monsters = {
      poring: []
      thanatos: []
    }

    @monster_limit = {
      poring: 0
      thanatos: 10
    }

  start: ->
    @gameScreen = $('<canvas id="gameScreen"></canvas>')[0]
    @gameScreen.width = $(window).width()
    @gameScreen.height = $(window).height()
    $('body').html(@gameScreen)
    @context = @gameScreen.getContext("2d")
    @play()

  play: ->
    @painter = setInterval(@draw, 1000 / 60)

  pause: ->
    if @painter?
      clearInterval(@painter)
      @painter = undefined

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
        diff = @monster_count[k] - @monsters[k].length
        c = 0
        while c < diff
          por = new gameApp.Creature.Monster(k, @monster_sheet[k], @)
          @monsters[k].push(por)
          c++

    _.each @monsters, (v, k) =>
      _.each @monsters[k], (mon) =>
        mon.update()

  monster_spawn_multiple: 300

  incrementMonsters: ->
    _.each @monsters, (v, k) =>
      if @monster_count[k] < @monster_limit[k]
        @monster_count[k]++

  draw: =>
    @context.clearRect 0, 0, @gameScreen.width, @gameScreen.height

    #ctx.drawImage(sprite, 0, tileIndex * spriteSize, spriteSize, spriteSize, tileX, tileY, spriteSize, spriteSize);
    #http://www.w3schools.com/tags/canvas_drawimage.asp
    #context.drawImage(linkSheet, 0, 910, 120, 130, 0, 0, 120, 130);
    @updateMonsters()


    if (@timer % @monster_spawn_multiple) is 0
      @incrementMonsters()

    @timer++
    return

jQuery ->
  $('#gameScreen').width(window.width)
  $('#gameScreen').height(window.height)
  gameApp.main = new gameApp.Main()

  gameApp.main.start()

