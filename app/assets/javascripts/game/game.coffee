#= require game/phaser.min

# window for Browser
# exports for Node
root = @
root.global8ball ?= {}

FORCE_FACTOR = 0.1
MAX_FORCE = 100

class global8ball.Boot extends Phaser.State
  constructor: (@g8bGame)->

  preload: ->
    @g8bGame.overloadImageLoading()
    @g8bGame.makeTextsTranslatable()
    @game.load.image 'preloader-bar', 'game/preloader_bar.png'

  create: ->
    @game.stage.backgroundColor = '#000000'
    @game.state.start 'Preload'
    @game.scale.setGameSize 1200, 800
    @game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL

class global8ball.Preload extends Phaser.State
  constructor: (@g8bGame) ->

  preload: ->
    preloader = @game.add.sprite @game.width / 2, @game.height / 2, 'preloader-bar'
    preloader.anchor.setTo 0.5, 0.5
    loader = @game.load
    for key of Preload.IMAGES
      url = 'game/' + Preload.IMAGES[key]
      loader.image key, url

  @IMAGES:
    background: 'background.png'
    blackBall:  'black_ball.png'
    crosshair:  'crosshair.png'
    hole:       'hole.png'
    redBall:    'red_ball.png'
    table:      'table_pool_without_background.png'
    whiteBall:  'white_ball.png'
    yellowBall: 'yellow_ball.png'

  create: ->
    @game.state.start @g8bGame.currentState()

# Base class for all full Phaser states (i.e. with all images etc.)
class FullState extends Phaser.State
  constructor: (@g8bGame) ->

  create: ->
    @physics.startSystem Phaser.Physics.P2JS
    @game.physics.p2.restitution = 0.99999
    @game.physics.p2.setPostBroadphaseCallback @doesCollide
    @game.input.maxPointers = 1 # No multi-touch
    @tableFloor = @game.add.image @game.width / 2, @game.height / 2, 'background'
    @tableFloor.anchor.setTo 0.5, 0.5
    @table = @game.add.image @game.width / 2, @game.height / 2, 'table'
    @table.anchor.setTo 0.5, 0.5
    @createHoles()
    @createBalls()
    @createPlayerInfos()

  createHoles: ->
    holesData = @holesData()
    @holes = (@createHole key, holesData[key] for key of holesData)

  # @return {Hole}
  createHole: (key, holeData) ->
    sprite = @game.add.sprite holeData.pos.x, holeData.pos.y, 'hole'
    sprite.anchor.setTo 0.5, 0.5
    new Hole key, sprite

  holesData: () ->
    center = new Phaser.Point @game.width / 2, @game.height / 2
    xDiff = 480
    yDiff = 235
    yCenterDiff = 5
    # Minor corrections because table is slightly asymmetrical.
    leftTop:
      pos: center.clone().add -xDiff, -yDiff
    centerTop:
      pos: center.clone().add 0, -yDiff - yCenterDiff
    rightTop:
      pos: center.clone().add xDiff, -yDiff
    leftBottom:
      pos: center.clone().add -xDiff, yDiff - 5
    centerBottom:
      pos: center.clone().add 0, yDiff + yCenterDiff
    rightBottom:
      pos: center.clone().add xDiff, yDiff - 7

  createBalls: () ->
    @balls = @g8bGame.balls().map (ballData) => @createBall ballData

  # @return {Ball}
  createBall: (ballData) ->
    pos = @g8bGame.translatePosition ballData.pos
    sprite = @game.add.sprite pos.x, pos.y, ballData.color + 'Ball'
    sprite.anchor.setTo 0.5, 0.5
    ball = new Ball ballData, sprite
    @game.physics.enable sprite, Phaser.Physics.P2
    @game.physics.p2.enable sprite
    ball

  createPlayerInfos: () ->
    you = @game.add.text 20, 30, {message: 'game.player_info.you', context: { name: @g8bGame.you().name } }
    you.anchor.setTo 0, 0
    you.fill = '#ffffff'
    enemy = @game.add.text @game.width - 20, 30, {message: 'game.player_info.enemy', context: { name: @g8bGame.enemy().name } }
    enemy.anchor.setTo 1, 0
    enemy.fill = '#ffffff'
    @players =
      you: you
      enemy: enemy

  # By default, everything collides.
  doesCollide: =>
    true

class Hole
  constructor: (@key, @sprite) ->

class Ball
  constructor: (@data, @sprite) ->

class PlayState extends FullState
  constructor: (g8bGame, @hasUi = true) ->
    super(g8bGame)
    @aimLine = null
    @shot = new Phaser.Signal

  create: ->
    super()
    if @hasUi
      @game.input.onDown.add @pointerDown
      @game.input.onUp.add @pointerUp
      @game.input.addMoveCallback @pointerMove
      @shotBmd = @game.make.bitmapData @game.width, @game.height
      @shotBmd.addToWorld()

  update: ->
    super()
    if @aimLine
      @aimLine.draw @shotBmd

  pointerDown: (event, rawEvent) =>
    if @canAim()
      @aimLine = new AimLine x: event.x, y: event.y

  pointerUp: (event, rawEvent) =>
    if rawEvent.type is "mouseup" # onUp seems to catch other events as well, even from outside canvas!
      @releaseShot()

  releaseShot: ->
    if @aimLine
      @shotBmd.cls()
      shot = @aimLine
      @aimLine = null
      # Dispatch shot in terms of abstract board coordinates, not pixels.
      @shot.dispatch @g8bGame.translatePositionBack(shot.start), @g8bGame.translatePositionBack(shot.end), 'you'

  pointerMove: (pointer, x, y, down) =>
    if @aimLine
      @aimLine.setEnd x: x, y: y

  # @return {Boolean}
  canAim: ->
    @aimLine is null and @canShoot()

  # @return {Boolean}
  canShoot: ->
    no

class global8ball.PlayForBegin extends PlayState
  constructor: (g8bGame, @eventSource) ->
    super g8bGame
    @shot.add @shoot

  create: ->
    super()
    @yourCue = @createCue 'you'
    @enemyCue = @createCue 'enemy'
    @youShot = @g8bGame.data.players.you.shot
    @enemyShot = @g8bGame.data.players.enemy.shot

  # @return {Cue}
  createCue: (player) ->
    sprite = @add.sprite 'whiteBall'
    cue = new Cue sprite, player
    return cue

  update: ->
    super()
    if @eventSource.youShot() and not @youShot
      @youShot = true
    if @eventSource.enemyShot() and not @enemyShot
      @enemyShot = true

  # Attempt to shoot. If shooting is allowed, teleport the shooting player's
  # cue to an appropriate position and accelerate it accordingly.
  # Shooting positions are abstract board positions and must be translated back.
  #
  # @param {Point} start
  # @param {Point} end
  # @param {string} player
  shoot: (start, end, player) =>
    return
    rs = @g8bGame.translatePositionBack start
    re = @g8bGame.translatePositionBack end
    dx = re.x - rs.x
    dy = re.y - rs.y
    abs = Math.sqrt dx*dx + dy*dy
    f = if abs > MAX_FORCE then MAX_FORCE / abs else 1
    dx *= FORCE_FACTOR / f
    dy *= FORCE_FACTOR / f
    @balls.filter((ball) -> ball.data.id is 'you').forEach (ball) -> ball.sprite.body.applyImpulse [-dx, -dy]

  # @inheritdoc
  canShoot: ->
    not @youShot

class Cue
  constructor: (@sprite, @player) ->

class global8ball.EventSource
  youShot: () ->
    false

  enemyShot: () ->
    false

class AimLine
  constructor: (@start) ->
    @end = x: @start.x, y: @start.y

  draw: (bitmapData) ->
    bitmapData.cls()
    bitmapData.line @start.x, @start.y, @end.x, @end.y, '#ff0000', 5

  setEnd: (point) ->
    @end = x: point.x, y: point.y

class global8ball.PlayForVictory extends PlayState

class global8ball.ShowResult extends FullState
  create: ->
    super()
    @victoryText = @game.add.text @game.width / 2, 10, {message: 'game.show_victory.win', context: { name: @g8bGame.winner() }}
    @victoryText.anchor.setTo 0.5, 0
    @victoryText.fill = '#ffffff'
