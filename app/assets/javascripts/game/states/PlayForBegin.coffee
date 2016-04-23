#= require game/states/PlayState

class global8ball.PlayForBegin extends global8ball.PlayState
  constructor: (g8bGame, @eventSource) ->
    super g8bGame
    @shot.add @shoot

  create: ->
    super()
    @addCollisionGroups ['white1', 'white2']
    @youShot = @g8bGame.data.players.you.shot
    @enemyShot = @g8bGame.data.players.enemy.shot
    @addWhiteBallPhysics 'you', @collisionGroups.white1, @collisionGroups.white2, @collisionGroups.cue1
    @addWhiteBallPhysics 'enemy', @collisionGroups.white2, @collisionGroups.white1, @collisionGroups.cue2
    @yourBall = (@balls.filter((ball) -> ball.id is 'you'))[0]
    @enemyBall = (@balls.filter((ball) -> ball.id is 'enemy'))[0]
    @yourCue.setTargetBall @yourBall
    @yourCue.show()
    @enemyCue.setTargetBall @enemyBall
    @getPhysicsGroupSpecs().forEach (spec) =>
      @physicsGroups[spec.id] = new global8ball.PhysicsGroup spec.spriteKey, @spriteGroups[spec.spriteGroupId] @collisionGroups[spec.collisionGroupId]
      (spec.collides or []).forEach (collision) =>
        @physicsGroups[spec.id].collides @collisionGroups[collision.groupId], @[collision.callback], @

  getPhysicsGroupSpecs: () -> []

  addWhiteBallPhysics: (ballId, myBallCollisionGroup, otherBallCollisionGroup, cueCollisionGroup) ->
    @balls.filter((ball) -> ball.id is ballId).forEach (ball) =>
      ball.body.setCollisionGroup otherBallCollisionGroup
      ball.body.collides @collisionGroups.borders, @whiteBallCollidesWithBorder
      ball.body.collides cueCollisionGroup
      ball.body.collides otherBallCollisionGroup
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
      ball.body.velocity.x = dx
      ball.body.velocity.y = dy

  # @inheritdoc
  canShoot: ->
    not @youShot
