window.initGlobal8Ball = (e) ->
  game = new Game { width: 800, height: 600}, document.getElementById('da-game'), window.assets.images
  game.start()

class Boot extends Phaser.State
  constructor: (@imageUrlMap)->

  preload: ->
    @game.load.image 'preloader-bar', @imageUrlMap['game/preloader_bar.png']

  create: ->
    @game.state.start 'Preload'

class Preload extends Phaser.State
  constructor: (@imageUrlMap)->

  preload: ->
    preloader = @game.add.sprite 400, 300, 'preloader-bar'
    preloader.anchor.setTo 0.5, 0.5

class Game
  constructor: (@size, @parent, @imageUrlMap)->
    console.log @imageUrlMap
    @renderer = Phaser.AUTO

  headless: ->
    @renderer = Phaser.HEADLESS

  start: ->
    @phaserGame = new Phaser.Game @size.width, @size.height, @renderer, @parent
    @phaserGame.state.add 'Boot', new Boot(@imageUrlMap), true
    @phaserGame.state.add 'Preload', new Preload(@imageUrlMap)
