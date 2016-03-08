# window for Browser
# exports for Node
root = @

class Boot extends Phaser.State
  constructor: (@imageUrlMap)->

  preload: ->
    @overloadImageLoading()
    @game.load.image 'preloader-bar', 'game/preloader_bar.png'

  create: ->
    @game.state.start 'Preload'
    @game.scale.setGameSize 1200, 800
    @game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL

  # To avoid using the image URL mapping over and over again, replace image
  # methods on loader with methods doing the mapping before.
  overloadImageLoading: ->
    imageUrlMap = @imageUrlMap # For lexical binding
    load = @game.load
    oldLoadImage = load.image.bind load
    load.image = (key, url, overwrite) ->
      oldLoadImage key, imageUrlMap[url], overwrite
    oldLoadImages = load.images.bind load
    load.images = (keys, urls) ->
      oldLoadImage keys, urls.map (url) -> imageUrlMap[url]

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

class PlayForBegin extends FullState

class PlayForVictory extends FullState

class ShowResult extends FullState

class Game
  # @config is the game config
  # @data is the current state of the game, i.e. which ball is where, has anybody won, etc.
  constructor: (@config, @data)->
    @renderer = if @config.server then Phaser.HEADLESS else Phaser.AUTO
    @I18n = root.I18n

  start: ->
    @phaserGame = new Phaser.Game @config.size.width, @config.size.height, @renderer, @config.parent
    @phaserGame.state.add 'Boot', new Boot(@config.imageUrlMap), true
    @phaserGame.state.add 'Preload', new Preload @
    @phaserGame.state.add 'PlayForBegin', new PlayForBegin @
    @phaserGame.state.add 'PlayForVictory', new PlayForVictory @
    @phaserGame.state.add 'ShowResult', new ShowResult @

  currentState: ->
    switch @data.state
      when 'PlayForBegin', 'PlayForVictory', 'ShowResult' then @data.state
      else throw new Error "Invalid game state."

root.Game = Game
