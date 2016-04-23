#= require game/prolog

# Base class for all full Phaser states (i.e. with all images etc.)
class global8ball.FullState extends Phaser.State
  constructor: (@g8bGame) ->
    @spriteGroups = {}
    @collisionGroups = {}
    @physicsGroups = {}

  addGroup: (collisionGroupName, spriteGroupName = collisionGroupName, spriteClassType = Phaser.Sprite) ->
    @collisionGroups[collisionGroupName] ?= @physics.p2.createCollisionGroup()
    if not @spriteGroups[spriteGroupName]
      @spriteGroups[spriteGroupName] = @add.group()
      @spriteGroups[spriteGroupName].classType = spriteClassType

  addSpriteGroup: (groupName, classType) ->
    @spriteGroups[groupName] = @add.group()
    if classType
      @spriteGroups[groupName].classType = classType

  create: ->
    @physics.startSystem Phaser.Physics.P2JS
    @physics.p2.restitution = 0.99999
    @physics.p2.setImpactEvents on
    @addGroup 'table'
    @addGroup 'borders'
    @addSpriteGroup 'holes', global8ball.Hole
    @addSpriteGroup 'balls', global8ball.Ball
    @game.input.maxPointers = 1 # No multi-touch
    @tableFloor = @game.add.image @game.width / 2, @game.height / 2, 'background', `/*frame=*/ undefined`, @spriteGroups.table
    @tableFloor.anchor.setTo 0.5, 0.5
    @table = @game.add.image @game.width / 2, @game.height / 2, 'table'
    @table.anchor.setTo 0.5, 0.5
    @addCollisionGroups ['hole']
    @createHoles()
    @createBalls()
    @createPlayerInfos()
    @borders = @createBorders()
    @world.sendToBack @spriteGroups.table

  addCollisionGroups: (baseNames) ->
    baseNames.forEach (baseName) =>
      @collisionGroups[baseName] = @physics.p2.createCollisionGroup()

  createBorders: ->
    @spriteGroups.borders.enableBody = true
    @spriteGroups.borders.physicsBodyType = Phaser.Physics.P2JS
    bordersData = @borderData()
    for borderKey of bordersData
      borderData = bordersData[borderKey]
      border = @spriteGroups.borders.create borderData.pos.x, borderData.pos.y, 'border'
      border.borderKey = borderKey
      border.width = borderData.size.width
      border.height = borderData.size.height
      border.visible = no
      border.body.setRectangleFromSprite border
      border.body.static = yes # Borders are immobile
      border.body.setCollisionGroup @collisionGroups.borders
    @spriteGroups.borders

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
    sprite = @spriteGroups.holes.create holeData.pos.x, holeData.pos.y, 'hole'
    sprite.anchor.setTo 0.5, 0.5
    sprite.holeKey = key
    sprite

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
    ball = @spriteGroups.balls.create pos.x, pos.y, ballData.color + 'Ball'
    ball.setData ballData
    @physics.p2.enable ball
    ball.body.setCircle 16
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

  createSprite: (physicsId, x, y, config = {}) ->
    @physicsGroups[physicsId].create x, y, config