#= require game/game

window.initGlobal8Ball = (e) ->
  config =
    imageUrlMap: window.assets.images
    parent: document.getElementById 'da-game'
    size:
      width: 800
      height: 600
  gameState =
    state: 'ShowResult'
    balls: [
      {
        color: 'black'
        pos: x: 200, y: 300
      },
      {
        color: 'red'
        pos: x: 250, y: 300
      },
      {
        color: 'white'
        pos: x: 300, y: 300
      },
      {
        color: 'yellow'
        pos: x: 350, y: 300
      }
    ]
  game = new Game config, gameState
  game.start()
