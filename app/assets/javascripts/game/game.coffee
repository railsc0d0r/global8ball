#= require game/phaser.min

# window for Browser
# exports for Node
root = @
root.global8ball ?= {}

FORCE_FACTOR = 10
MAX_FORCE = 1000

class global8ball.Ball extends Phaser.Sprite
  setData: (@data) ->
    @id = @data.id

class global8ball.Cue extends Phaser.Sprite
  LENGTH = 250
  MATH_FACTOR = Math.PI/180

  power: 0
  targetBall: null

  hide: ->
    @visible = no

  show: ->
    if @targetBall
      @updatePosition()
      @visible = yes

  setTargetBall: (@targetBall) ->
    @updatePosition()

  # @param {number} newAngle New angle in degrees (0-360)
  setAngle: (newAngle) ->
    @body.angle = newAngle
    @updatePosition()

  # @param {Point} Position to aim at. The cue will point TO that position, not FROm it!
  setAngleByAim: (pos) ->
    if @targetBall
      @setAngle Math.atan2(@targetBall.body.y - pos.y, @targetBall.body.x - pos.x) / MATH_FACTOR

  updatePosition: ()->
    if @targetBall
      @body.x = @targetBall.x + LENGTH * Math.cos(MATH_FACTOR * @body.angle)
      @body.y = @targetBall.y + LENGTH * Math.sin(MATH_FACTOR * @body.angle)

class global8ball.Hole extends Phaser.Sprite

class global8ball.EventSource
  youShot: () ->
    false

  enemyShot: () ->
    false
