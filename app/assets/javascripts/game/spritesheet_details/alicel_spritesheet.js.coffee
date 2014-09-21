class gameApp.AlicelSpritesheet
  constructor: (elementId, parent) ->
    @parent = parent
    @spritesheetObject = new Image()#document.getElementById(elementId)
    @spritesheetObject.src = 'images/alicel.png'
    @animationDetails =
      idle:
        front:
          animationName: "idleFront"
          numberOfFrames: 6
          width: 75
          height: 100
          xPosition: 0
          yPosition: 0
        back:
          animationName: "idleBack"
          numberOfFrames: 6
          width: 70
          height: 125
          xPosition: 451
          yPosition: 0

      walk:
        front:
          animationName: "walkingFront"
          numberOfFrames: 6
          width: 75
          height: 100
          xPosition: 0
          yPosition: 0
        back:
          animationName: "walkingBack"
          numberOfFrames: 6
          width: 70
          height: 125
          xPosition: 451
          yPosition: 0

      attack:
        front:
          a:
            animationName: "attackingFrontA"
            numberOfFrames: 2
            width: 70
            height: 100
            xPosition: 0
            yPosition: 121
          b:
            animationName: "attackingFrontB"
            numberOfFrames: 2
            width: 95
            height: 100
            xPosition: 141
            yPosition: 121
          c:
            animationName: "attackingFrontC"
            numberOfFrames: 1
            width: 70
            height: 100
            xPosition: 331
            yPosition: 121

        back:
          a:
            animationName: "attackingBackA"
            numberOfFrames: 2
            width: 75
            height: 100
            xPosition: 401
            yPosition: 121
          b:
            animationName: "attackingBackB"
            numberOfFrames: 2
            width: 105
            height: 100
            xPosition: 551
            yPosition: 121
          c:
            animationName: "attackingBackC"
            numberOfFrames: 1
            width: 75
            height: 100
            xPosition: 761
            yPosition: 121


    #animation_details
    @_initAnimationObject()
    @spritesheetObject.onload = =>

      @animations.idle.front.left = @animations.walk.front.left = gameApp.extractFrames(@spritesheetObject, @animationDetails.walk.front)
      @animations.idle.front.right = @animations.walk.front.right = gameApp.extractFrames(@spritesheetObject, @animationDetails.walk.front, {flip_horizontal: true})
      @animations.idle.back.left = @animations.walk.back.left = gameApp.extractFrames(@spritesheetObject, @animationDetails.walk.back)
      @animations.idle.back.right = @animations.walk.back.right = gameApp.extractFrames(@spritesheetObject, @animationDetails.walk.back, {flip_horizontal: true})
      # attack front
      _aflA = gameApp.extractFrames(@spritesheetObject, @animationDetails.attack.front.a)
      _aflB = gameApp.extractFrames(@spritesheetObject, @animationDetails.attack.front.b)
      _aflC = gameApp.extractFrames(@spritesheetObject, @animationDetails.attack.front.c)

      _afrA = gameApp.extractFrames(@spritesheetObject, @animationDetails.attack.front.a, {flip_horizontal: true})
      _afrB = gameApp.extractFrames(@spritesheetObject, @animationDetails.attack.front.b, {flip_horizontal: true})
      _afrC = gameApp.extractFrames(@spritesheetObject, @animationDetails.attack.front.c, {flip_horizontal: true})

      @animations.attack.front.left = _.union(_aflA, _aflB , _aflC)
      @animations.attack.front.right = _.union(_afrA, _afrB , _afrC)

      # attack back
      _ablA = gameApp.extractFrames(@spritesheetObject, @animationDetails.attack.back.a)
      _ablB = gameApp.extractFrames(@spritesheetObject, @animationDetails.attack.back.b)
      _ablC = gameApp.extractFrames(@spritesheetObject, @animationDetails.attack.back.c)

      _abrA = gameApp.extractFrames(@spritesheetObject, @animationDetails.attack.back.a, {flip_horizontal: true})
      _abrB = gameApp.extractFrames(@spritesheetObject, @animationDetails.attack.back.b, {flip_horizontal: true})
      _abrC = gameApp.extractFrames(@spritesheetObject, @animationDetails.attack.back.c, {flip_horizontal: true})

      @animations.attack.back.left = _.union(_ablA, _ablB , _ablC)
      @animations.attack.back.right = _.union(_abrA, _abrB , _abrC)




    return

  _initAnimationObject: ->
    @animations = {
      idle: {
        front: {}
        back: {}
      }
      walk: {
        front: {}
        back: {}
      }
      attack: {
        front: {}
        back: {}
      }
    }
