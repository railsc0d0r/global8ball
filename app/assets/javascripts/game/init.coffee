#= require game/game

# Currently mostly for testing purposes.
# The real game will take data and events from the server.
window.initGlobal8Ball = (e) ->
  config =
    imageUrlMap: window.assets.images
    parent: document.getElementById 'da-game'
    size:
      width: 800
      height: 600
  gameState =
    players:
      you:
        name: "David"
        shot: false
      enemy:
        name: "Goliath"
        shot: false
    state: 'PlayForBegin'
    balls: [
      {
        id: 'you'
        color: 'white'
        pos: x: -75, y: -25
      },
      {
        id: 'enemy'
        color: 'white'
        pos: x: -75, y: 25
      }
    ]
  game = new Game config, gameState
  game.start()
