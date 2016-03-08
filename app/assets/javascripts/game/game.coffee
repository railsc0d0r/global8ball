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
  constructor: ->

  preload: ->
    preloader = @game.add.sprite 400, 300, 'preloader-bar'
    preloader.anchor.setTo 0.5, 0.5

class PlayForBegin extends Phaser.State

class Play extends Phaser.State

class ShowResult extends Phaser.State

class Game
  constructor: (@config)->
    @renderer = Phaser.AUTO

  headless: ->
    @renderer = Phaser.HEADLESS

  start: ->
    @phaserGame = new Phaser.Game @config.size.width, @config.size.height, @renderer, @config.parent
    @phaserGame.state.add 'Boot', new Boot(@config.imageUrlMap), true
    @phaserGame.state.add 'Preload', new Preload
    @phaserGame.state.add 'PlayForBegin', new PlayForBegin
    @phaserGame.state.add 'Play', new Play
    @phaserGame.state.add 'ShowResult', new ShowResult

root.Game = Game
