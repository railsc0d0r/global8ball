#= require game/states/FullState

class global8ball.PlayState extends global8ball.FullState
  constructor: (g8bGame, @hasUi = true) ->
    super(g8bGame)
    @shot = new Phaser.Signal
    @aiming = false

  create: ->
    super()
    @yourCue = @createSprite 'cue1', 10, 10, visible: no
    @enemyCue = @createSprite 'cue2', 10, 10, visible: no
    if @hasUi
      @addCueControlGui()
      @game.input.onDown.add @pointerDown
      @game.input.onUp.add @pointerUp
      @game.input.addMoveCallback @pointerMove

  getPhysicsGroupSpecs: () ->
    specs = super()
    specs.cue1 =
      spriteKey: 'cue'
      spriteGroupId: 'cues'
      collisionGroupId: 'cue1'
    specs.cue2 =
      spriteKey: 'cue'
      spriteGroupId: 'cues'
      collisionGroupId: 'cue2'
    return specs

  spriteClasses: () ->
    classes = super()
    classes.cues = global8ball.Cue
    return classes

  addCueControlGui: ->
    @cueControlGui = {}
    hCenter = @game.width / 2
    y = @game.height - 70
    elements =
      forceStrength:
        x: hCenter
        y: y
        w: 200
        h: 40
      lessenForce:
        x: hCenter - 120
        y: y
        w: 40
        h: 40
      strengthenForce:
        x: hCenter + 120
        y: y
        w: 40
        h: 40
      shootButton:
        x: hCenter + 160
        y: y
        w: 40
        h: 40
    for id of elements
      @cueControlGui[id] = @game.add.button elements[id].x, elements[id].y, id
      @cueControlGui[id].anchor.setTo 0.5, 0.5
      @cueControlGui[id].width = elements[id].w
      @cueControlGui[id].height = elements[id].h
      @cueControlGui[id].inputEnabled = true

  update: ->
    super()

  pointerDown: (event, rawEvent) =>
    @aiming = true
    @aimAt rawEvent.clientX, rawEvent.clientY

  pointerUp: (event, rawEvent) =>
    if rawEvent.type is "mouseup" # onUp seems to catch other events as well, even from outside canvas!
      @aiming = false

  pointerMove: (event, x, y) =>
    if @aiming
      @aimAt x, y

  aimAt: (x, y) ->
    @yourCue.setAngleByAim x: x, y: y

  # @return {Boolean}
  canShoot: ->
    no

  cueCollidesWithWhiteBall: (cue, ball) ->
