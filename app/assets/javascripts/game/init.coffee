window.initGlobal8Ball = (e) ->
  size =
    width: 800
    height: 600
  game = new Game size, document.getElementById('da-game'), window.assets.images
  game.start()
