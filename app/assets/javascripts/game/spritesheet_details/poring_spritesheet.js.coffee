class gameApp.PoringSpritesheet
  constructor: (elementId, parent) ->
    @parent = parent
    @spritesheetObject = new Image()
    @spritesheetObject.src = 'images/poring.png'
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
        width: 47.5
        height: 46
        xPosition: 0
        yPosition: 94

      #walkingBack:
      #walkingLeft:
      #walkingRight

    #animation_details
    @animations = {}
    @spritesheetObject.onload= =>
      @animations["idleFront"] = gameApp.extractFrames(@spritesheetObject, @animationDetails.idleFront)
      @animations["walkingFront"] = gameApp.extractFrames(@spritesheetObject, @animationDetails.walkingFront)
    return