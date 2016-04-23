#= require game/states/FullState

class global8ball.PlayState extends global8ball.FullState
  constructor: (g8bGame, @hasUi = true) ->
    super(g8bGame)
    @shot = new Phaser.Signal
    @aiming = false

  create: ->
    super()
    @addSpriteGroup 'cues', global8ball.Cue
    @addCollisionGroups ['cue1', 'cue2']
    @yourCue = @createCue 'you', @collisionGroups.cue1
    @enemyCue = @createCue 'enemy', @collisionGroups.cue2
    if @hasUi
      @addCueControlGui()
      @game.input.onDown.add @pointerDown
      @game.input.onUp.add @pointerUp
      @game.input.addMoveCallback @pointerMove

  # @return {Cue}
  createCue: (player, collisionGroup) ->
    cue = @spriteGroups.cues.create 10, 10, 'cue'
    @physics.enable cue, Phaser.Physics.P2JS
    @physics.p2.enable cue
    cue.body.setCollisionGroup collisionGroup
    cue.visible = no
    return cue

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
      @cueControlGui[id] = @game.add.sprite elements[id].x, elements[id].y, id
      @cueControlGui[id].anchor.setTo 0.5, 0.5
      @cueControlGui[id].width = elements[id].w
      @cueControlGui[id].height = elements[id].h

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
