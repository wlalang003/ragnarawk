class gameApp.ThanatosSpritesheet
  constructor: (elementId, parent) ->
    @parent = parent
    @spritesheetObject = new Image()#document.getElementById(elementId)
    @spritesheetObject.src = 'images/thanatos.png'
    @animationDetails =
      idleFront:
        animationName: "idleFront"
        numberOfFrames: 4
        width: 49
        height: 47
        xPosition: 0
        yPosition: 0

      walkingFront:
        animationName: "walkingFront"
        numberOfFrames: 8
        width: 78
        height: 125
        xPosition: 0
        yPosition: 145

      #walkingBack:
      #walkingLeft:
      #walkingRight

    #animation_details
    @animations = {}

    @spritesheetObject.onload = =>
      @animations["idleFront"] = gameApp.extractFrames(@spritesheetObject, @animationDetails.idleFront)
      @animations["walkingFront"] = gameApp.extractFrames(@spritesheetObject, @animationDetails.walkingFront)

    return