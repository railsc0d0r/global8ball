#= require game/states/PlayState

class global8ball.PlayForVictory extends global8ball.PlayState
  constructor: (global8Game) ->
    super();

  create: ->
    @addCollisionGroups ['white', 'cue1', 'cue2', 'playBalls']
    super()

  update: ->
    super()
