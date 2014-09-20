window.gameApp = {
  Creature: {}
  Field: {}
  Utility: {}
  extractFrames: (spritesheet, animation, options={}) ->
    console.log "extracting frames.."
    frameSet = []
    ctr = 0

    while ctr < animation.numberOfFrames
      canvas = document.createElement("canvas")
      canvas.width = animation.width
      canvas.height = animation.height

      context = canvas.getContext("2d")
      console.log context

      #context.height.translate(width, 0)
      #context.height.scale(-1, 1)
      #console.log animation.width * ctr
      console.log options
      if options.flip_horizontal
        context.save
        context.scale(-1,1)
        context.drawImage spritesheet, animation.xPosition + (animation.width * ctr), animation.yPosition, animation.width, animation.height, -animation.width, 0, animation.width, animation.height
      else
        context.drawImage spritesheet, animation.xPosition + (animation.width * ctr), animation.yPosition, animation.width, animation.height, 0, 0, animation.width, animation.height

      frameSet[ctr] = canvas
      ctr++
    frameSet
 }