window.initGlobal8Ball = (e) ->
  size =
    width: 800
    height: 600
  game = new Game size, document.getElementById('da-game'), window.assets.images
  game.start()

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

class Game
  constructor: (@size, @parent, @imageUrlMap)->
    @renderer = Phaser.AUTO

  headless: ->
    @renderer = Phaser.HEADLESS

  start: ->
    @phaserGame = new Phaser.Game @size.width, @size.height, @renderer, @parent
    @phaserGame.state.add 'Boot', new Boot(@imageUrlMap), true
    @phaserGame.state.add 'Preload', new Preload
