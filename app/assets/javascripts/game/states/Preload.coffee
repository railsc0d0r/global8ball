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

  @IMAGES:
    background:      'background.png'
    blackBall:       'black_ball.png'
    border:          'border.png'
    crosshair:       'crosshair.png'
    cue:             'cue.png'
    forceStrength:   'force_strength.png'
    hole:            'hole.png'
    lessenForce:     'lessen_force.png'
    redBall:         'red_ball.png'
    shootButton:     'shoot_button.png'
    strengthenForce: 'strengthen_force.png'
    table:           'table_pool_without_background.png'
    whiteBall:       'white_ball.png'
    yellowBall:      'yellow_ball.png'

  create: ->
    @game.state.start @g8bGame.currentState()
