#= require game/phaser.min

# window for Browser
# exports for Node
root = @

class Boot extends Phaser.State
  constructor: (@g8bGame)->

  preload: ->
    @g8bGame.overloadImageLoading()
    @g8bGame.makeTextsTranslatable()
    @game.load.image 'preloader-bar', 'game/preloader_bar.png'

  create: ->
    @game.state.start 'Preload'
    @game.scale.setGameSize 1200, 800
    @game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL

class Preload extends Phaser.State
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

  createBall: (ballData) ->
    pos = @g8bGame.translatePosition ballData.pos
    sprite = @game.add.sprite pos.x, pos.y, ballData.color + 'Ball'
    sprite.anchor.setTo 0.5, 0.5
    new Ball ballData.color, sprite

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

class Hole
  constructor: (@key, @sprite) ->

class Ball
  constructor: (@color, @sprite) ->

class PlayForBegin extends FullState

class PlayForVictory extends FullState

class ShowResult extends FullState
  create: ->
    super()
    @victoryText = @game.add.text @game.width / 2, 10, {message: 'game.show_victory.win', context: { name: @g8bGame.winner() }}
    @victoryText.anchor.setTo 0.5, 0
    @victoryText.fill = '#ffffff'

class Game
  # @config is the game config
  # @data is the current state of the game, i.e. which ball is where, has anybody won, etc.
  constructor: (@config, @data)->
    @overload = new Game.Overload
    @renderer = if @config.server then Phaser.HEADLESS else Phaser.AUTO
    @I18n = root.I18n
    @createPositionTranslation()

  createPositionTranslation: ->
    first =
      left: -100
      right: 100
      top: -50
      bottom: 50
    second =
      left: 120
      right: 1080
      top: 170
      bottom: 630
    @positionTranslation = new Game.PositionTranslation first, second

  translatePosition: (point) ->
    @positionTranslation.to point

  t: (args...) ->
    @I18n.t.apply @I18n, args

  start: ->
    @phaserGame = new Phaser.Game @config.size.width, @config.size.height, @renderer, @config.parent
    @phaserGame.state.add 'Boot', new Boot(@), true
    @phaserGame.state.add 'Preload', new Preload @
    @phaserGame.state.add 'PlayForBegin', new PlayForBegin @
    @phaserGame.state.add 'PlayForVictory', new PlayForVictory @
    @phaserGame.state.add 'ShowResult', new ShowResult @

  currentState: ->
    switch @data.state
      when 'PlayForBegin', 'PlayForVictory', 'ShowResult' then @data.state
      else throw new Error "Invalid game state."

  winner: ->
    "Someone"

  balls: ->
    @data.balls ? []

  enemy: ->
    @data.players.enemy

  you: ->
    @data.players.you

  # To avoid using the image URL mapping over and over again, replace image
  # methods on loader with methods doing the mapping before.
  overloadImageLoading: ->
    imageUrlMap = @config.imageUrlMap # For lexical binding
    @overload.overload @phaserGame.load, 'image', (oldLoadImage) -> (key, url, overwrite) -> oldLoadImage key, imageUrlMap[url], overwrite
    @overload.overload @phaserGame.load, 'images', (oldLoadImages) -> (key, urls) -> oldLoadImages keys, urls.map (url) -> imageUrlMap[url]

  # For easier use of translations, overload Phaser text method.
  makeTextsTranslatable: ->
    I18n = @I18n
    @overload.overload @phaserGame.add, 'text', (oldAddText) ->
      (x, y, text, style, group) ->
        oldAddText x, y, (if typeof text is 'string' then I18n.t(text) else I18n.t(text.message, text.context)), style, group

# Helper class to overload methods.
class Game.Overload
  overload: (context, methodName, newMethodFactory) ->
    oldMethod = context[methodName].bind context
    context[methodName] = newMethodFactory oldMethod

# Translates coordinates from one coordinate system to another and back.
class Game.PositionTranslation
  constructor: (@first, @second) ->
    @firstWidth = @first.right - @first.left
    @firstHeight = @first.bottom - @first.top
    @secondWidth = @second.right - @second.left
    @secondHeight = @second.bottom - @second.top
    @toFactor =
      horizontal: @secondWidth / @firstWidth
      vertical: @secondHeight / @firstHeight
    @fromFactor =
      horizontal: 1 / @toFactor.horizontal
      vertical: 1 / @toFactor.vertical

  to: (point) ->
    x: @second.left + (point.x - @first.left) * @toFactor.horizontal
    y: @second.top + (point.y - @first.top) * @toFactor.vertical

  from: (point) ->
    x: @first.left + (point.x - @second.left)  * @fromFactor.horizontal
    y: @first.top + (point.y - @second.top) * @fromFactor.vertical

root.Game = Game
