#= require game/phaser.min

# window for Browser
# exports for Node
root = @
root.global8ball ?= {}

FORCE_FACTOR = 10
MAX_FORCE = 1000

class Ball
  constructor: (@data, @sprite) ->
    @id = @data.id
    @sprite.ball = @

class Cue
  constructor: (@sprite, @player) ->
    @sprite.cue = @
    @power = 0
    @angle = 0

class global8ball.EventSource
  youShot: () ->
    false

  enemyShot: () ->
    false

class Hole
  constructor: (@key, @sprite) ->

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
    border:     'border.png'
    crosshair:  'crosshair.png'
    cue:        'white_ball.png'
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
    @physics.p2.restitution = 0.99999
    @physics.p2.setImpactEvents on
    @game.input.maxPointers = 1 # No multi-touch
    @tableFloor = @game.add.image @game.width / 2, @game.height / 2, 'background'
    @tableFloor.anchor.setTo 0.5, 0.5
    @table = @game.add.image @game.width / 2, @game.height / 2, 'table'
    @table.anchor.setTo 0.5, 0.5
    @addCollisionGroups ['border', 'hole']
    @createHoles()
    @createBalls()
    @createPlayerInfos()
    @borders = @createBorders()

  addCollisionGroups: (baseNames) ->
    baseNames.forEach (baseName) =>
      @[baseName + 'CollisionGroup'] = @physics.p2.createCollisionGroup()

  createBorders: ->
    borders = @add.group()
    borders.enableBody = true
    borders.physicsBodyType = Phaser.Physics.P2JS
    bordersData = @borderData()
    for borderKey of bordersData
      borderData = bordersData[borderKey]
      border = borders.create borderData.pos.x, borderData.pos.y, 'border'
      border.borderKey = borderKey
      border.width = borderData.size.width
      border.height = borderData.size.height
      border.visible = no
      border.body.setRectangleFromSprite border
      border.body.static = yes # Borders are immobile
      border.body.setCollisionGroup @borderCollisionGroup
    borders

  # There a six borders, they are located between the holes.
  borderData: ->
    center = new Phaser.Point @game.width / 2, @game.height / 2
    horizontalSize = width: 460, height: 15
    verticalSize = width: 15, height: 460
    hXDiff = 240
    hYDiff = 245
    vXDiff = 485
    vYDiff = 0
    bottomLeft:
      size: horizontalSize
      pos: center.clone().add -hXDiff, hYDiff
    bottomRight:
      size: horizontalSize
      pos: center.clone().add hXDiff, hYDiff
    left:
      size: verticalSize
      pos: center.clone().add -vXDiff - 5, vYDiff
    right:
      size: verticalSize
      pos: center.clone().add vXDiff, vYDiff
    topLeft:
      size: horizontalSize
      pos: center.clone().add -hXDiff, -hYDiff - 7
    topRight:
      size: horizontalSize
      pos: center.clone().add hXDiff, -hYDiff - 7

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
    yDiff = 238
    yCenterDiff = 9
    # Minor corrections because table is slightly asymmetrical.
    leftTop:
      pos: center.clone().add -xDiff, -yDiff - 1
    centerTop:
      pos: center.clone().add 0, -yDiff - yCenterDiff - 1
    rightTop:
      pos: center.clone().add xDiff - 2, -yDiff - 2
    leftBottom:
      pos: center.clone().add -xDiff, yDiff - 1
    centerBottom:
      pos: center.clone().add 0, yDiff + yCenterDiff - 1
    rightBottom:
      pos: center.clone().add xDiff + 1, yDiff - 4

  createBalls: () ->
    @balls = @g8bGame.balls().map (ballData) => @createBall ballData

  # @return {Ball}
  createBall: (ballData) ->
    pos = @g8bGame.translatePosition ballData.pos
    sprite = @add.sprite pos.x, pos.y, ballData.color + 'Ball'
    ball = new Ball ballData, sprite
    @physics.p2.enable sprite
    sprite.body.setCircle 16
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

class PlayState extends FullState
  constructor: (g8bGame, @hasUi = true) ->
    super(g8bGame)
    @shot = new Phaser.Signal

  create: ->
    super()
    @addCollisionGroups ['cue1', 'cue2']
    @yourCue = @createCue 'you', @cue1CollisionGroup
    @enemyCue = @createCue 'enemy', @cue2CollisionGroup
    if @hasUi
      @game.input.onDown.add @pointerDown
      @game.input.onUp.add @pointerUp
      @game.input.addMoveCallback @pointerMove
      @shotBmd = @game.make.bitmapData @game.width, @game.height
      @shotBmd.addToWorld()

  # @return {Cue}
  createCue: (player, collisionGroup) ->
    sprite = @add.sprite 10, 10, 'cue'
    @physics.enable sprite, Phaser.Physics.P2JS
    @physics.p2.enable sprite
    sprite.body.setCollisionGroup collisionGroup
    sprite.visible = no
    cue = new Cue sprite, player
    return cue

  update: ->
    super()

  pointerDown: (event, rawEvent) =>

  pointerUp: (event, rawEvent) =>
    if rawEvent.type is "mouseup" # onUp seems to catch other events as well, even from outside canvas!
      true # Do nothing

  # @return {Boolean}
  canShoot: ->
    no

class global8ball.PlayForBegin extends PlayState
  constructor: (g8bGame, @eventSource) ->
    super g8bGame
    @shot.add @shoot

  create: ->
    super()
    @addCollisionGroups ['white1', 'white2']
    @youShot = @g8bGame.data.players.you.shot
    @enemyShot = @g8bGame.data.players.enemy.shot
    @addWhiteBallPhysics 'you', @white1CollisionGroup, @white2CollisionGroup, @cue1CollisionGroup
    @addWhiteBallPhysics 'enemy', @white2CollisionGroup, @white1CollisionGroup, @cue2CollisionGroup

  addWhiteBallPhysics: (ballId, myBallCollisionGroup, otherBallCollisionGroup, cueCollisionGroup) ->
    @balls.filter((ball) -> ball.id is ballId).forEach (ball) =>
      ball.sprite.body.setCollisionGroup myBallCollisionGroup
      ball.sprite.body.collides @borderCollisionGroup, @whiteBallCollidesWithBorder
      ball.sprite.body.collides cueCollisionGroup
      ball.sprite.body.collides otherBallCollisionGroup
      @borders.forEach (border) =>
        border.body.collides myBallCollisionGroup

  whiteBallCollidesWithBorder: (ballBody, borderBody) =>

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
    rs = @g8bGame.translatePositionBack start
    re = @g8bGame.translatePositionBack end
    dx = re.x - rs.x
    dy = re.y - rs.y
    abs = Math.sqrt dx*dx + dy*dy
    f = if abs > MAX_FORCE then MAX_FORCE / abs else 1
    dx *= FORCE_FACTOR / f
    dy *= FORCE_FACTOR / f
    @balls.filter((ball) -> ball.id is 'you').forEach (ball) ->
      ball.sprite.body.velocity.x = dx
      ball.sprite.body.velocity.y = dy

  # @inheritdoc
  canShoot: ->
    not @youShot

class global8ball.PlayForVictory extends PlayState
  constructor: (global8Game) ->
    super();

  create: ->
    @addCollisionGroups ['white', 'cue1', 'cue2', 'playBalls']
    super()

  update: ->
    super()

class global8ball.ShowResult extends FullState
  create: ->
    super()
    @victoryText = @game.add.text @game.width / 2, 10, {message: 'game.show_victory.win', context: { name: @g8bGame.winner() }}
    @victoryText.anchor.setTo 0.5, 0
    @victoryText.fill = '#ffffff'
