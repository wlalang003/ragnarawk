class gameApp.PoringSpritesheet
  constructor: (elementId, parent) ->
    @parent = parent
    @spritesheetObject = document.getElementById(elementId)
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

    #animation_details
    @animations = {}
    @animations["idleFront"] = gameApp.extractFrames(@spritesheetObject, @animationDetails.idleFront)
    @animations["walkingFront"] = gameApp.extractFrames(@spritesheetObject, @animationDetails.walkingFront)
    return