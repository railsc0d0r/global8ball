#= require game/prolog

class global8ball.Preload extends Phaser.State
  constructor: (@g8bGame) ->

  preload: ->
    preloader = @game.add.sprite @game.width / 2, @game.height / 2, 'preloader-bar'
    preloader.anchor.setTo 0.5, 0.5
    loader = @game.load
    for key of Preload.IMAGES
      url = 'game/' + Preload.IMAGES[key]
      loader.image key, url
    for key of Preload.SPRITESHEETS
      spritesheet = Preload.SPRITESHEETS[key]
      url = 'game/' + spritesheet.url
      loader.spritesheet key, url, spritesheet.width, spritesheet.height

  @IMAGES:
    background:      'background.png'
    blackBall:       'black_ball.png'
    border:          'border.png'
    crosshair:       'crosshair.png'
    cue:             'cue.png'
    forceStrength:   'force_strength.png'
    hole:            'hole.png'
    redBall:         'red_ball.png'
    table:           'table_pool_without_background.png'
    whiteBall:       'white_ball.png'
    yellowBall:      'yellow_ball.png'

  @SPRITESHEETS:
    lessenForce:
      url: 'lessen_force.png'
      width: 576
      height: 440
    shootButton:
      url: 'shoot_button.png'
      width: 280
      height: 279
    strengthenForce:
      url: 'strengthen_force.png'
      width: 576
      height: 440

  create: ->
    @game.state.start @g8bGame.currentState()
