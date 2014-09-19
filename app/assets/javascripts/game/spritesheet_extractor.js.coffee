gameApp.extractFrames = (spritesheet, animation) ->
  console.log "extracting frames.."
  frameSet = []
  ctr = 0

  while ctr < animation.numberOfFrames
    canvas = document.createElement("canvas")
    canvas.width = animation.width
    canvas.height = animation.height
    context = canvas.getContext("2d")
    console.log animation.width * ctr
    context.drawImage spritesheet, animation.width * ctr, animation.yPosition, animation.width, animation.height, 0, 0, animation.width, animation.height
    frameSet[ctr] = canvas
    ctr++
  frameSet