window.initGlobal8Ball = (e) ->
  config =
    imageUrlMap: window.assets.images
    parent: document.getElementById 'da-game'
    size:
      width: 800
      height: 600
  game = new Game config
  game.start()
