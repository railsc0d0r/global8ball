#= require game/prolog

# Adds cue controls to a Phaser state. This is done by creating a StateControls
# instance every time a play state is entered (exactly: when Phaser.State.create()
# is called).
class global8ball.Controls
  constructor: (@g8bGame) ->

  # Attaches itself to the events of a state.
  #
  # @param {Phaser.State} state
  attach: (state) ->
    state.stateEvents.add @stateEventHappened, @

  # Listener attached to state events.
  #
  # @param {Phaser.State} state State causing the event.
  # @param {string} eventType
  stateEventHappened: (state, eventType) ->
    if eventType is 'create'
      @addControls state

  # Add controls to a state.
  #
  # @param {Phaser.State} state
  addControls: (state) ->
    StateControls.addTo state

# When entering a play state, an instance of this class is created and used
# to add controls and connect events.
class StateControls

  # Creates new state controls and adds them to the state.
  #
  # @param {Phaser.State} state
  @addTo: (state) ->
    (new StateControls state).attach()

  # @param {Phaser.State} state
  constructor: (@state) ->
    @aimingNextFrame = null
    @aiming = false
    @shotStrength = 0.5
    @shotStrengthChange = 0
    @currentlySettingForce = false

  attach: () ->
    if @attached # If already attached to the state, do not attach again.
      return @
    @attach = () =>

    @stateEventBinding = @state.stateEvents.add @stateEventHappened, @
    @addCueControlGui @state
    @state.input.onDown.add @pointerDown, @, 0
    @state.input.onUp.add @pointerUp, @, 0
    @state.input.addMoveCallback @pointerMove

  # Callback for state events.
  #
  # @param {Phaser.State} state
  # @param {string} eventType
  stateEventHappened: (state, eventType) ->
    if typeof @[eventType] is 'function'
      @[eventType]()

  # Called when the state shutdowns. Sprites do not need to be cleaned up (they
  # are automatically deleted by Phaser), but event bindings have to be
  # disconnected.
  shutdown: () ->
    @stateEventBinding.detach()
    @state.game.input.deleteMoveCallback @pointerMove

  # Called on every update of the state. Handles changes regarding shot strength.
  update: () ->
    if @shotStrengthChange isnt 0
      @shotStrength = Math.min 1, Math.max 0, @shotStrength + @shotStrengthChange
      @updateShotStrengthMask()
    if @aimingNextFrame
      if @shotStrengthChange is 0 and not @currentlySettingForce
        @aiming = true
        @state.aimAt @aimingNextFrame.x, @aimingNextFrame.y
      @aimingNextFrame = null

  addCueControlGui: () ->
    @cueControlGui = {}
    hCenter = @state.game.width / 2
    y = @state.game.height - 70
    elements =
      forceStrength:
        x: hCenter
        y: y
        w: 200
        h: 40
      lessenForce:
        x: hCenter - 120
        y: y
        w: 40
        h: 40
      strengthenForce:
        x: hCenter + 120
        y: y
        w: 40
        h: 40
      shootButton:
        x: hCenter + 160
        y: y
        w: 40
        h: 40
    for id of elements
      @cueControlGui[id] = @state.game.add.sprite elements[id].x, elements[id].y, id
      @cueControlGui[id].anchor.setTo 0.5, 0.5
      @cueControlGui[id].width = elements[id].w
      @cueControlGui[id].height = elements[id].h
      @cueControlGui[id].inputEnabled = true
      @cueControlGui[id].events.onInputOver.add @hoverOverControlGui
      @cueControlGui[id].events.onInputOut.add @leaveControlGui
    @cueControlGui.lessenForce.events.onInputDown.add @startLesseningForce, @, 1000
    @cueControlGui.strengthenForce.events.onInputDown.add @startStrengtheningForce, @, 1000
    @cueControlGui.forceStrength.events.onInputDown.add @startSettingForce, @, 1000
    @cueControlGui.shootButton.events.onInputDown.add @pressShootButton, @, 1000
    @shotStrengthMask = @state.game.add.graphics 0, 0
    @cueControlGui.forceStrength.mask = @shotStrengthMask
    @shotStrengthMask.beginFill '#ffffff'
    @updateShotStrengthMask()

  pointerDown: (event, rawEvent) =>
    @aimingNextFrame = x: event.x, y: event.y

  pointerUp: (event, rawEvent) =>
    if rawEvent.type is "mouseup" # onUp seems to catch other events as well, even from outside canvas!
      @aiming = false
      @stopSettingForce()
      @stopChangingForce()

  pointerMove: (event, x, y) =>
    @settingForce event, x, y
    if @aiming
      @state.aimAt x, y

  startLesseningForce: (sprite, event) =>
    @shotStrengthChange = -@forceChangeSpeed

  startStrengtheningForce: (sprite, event) =>
    @shotStrengthChange = @forceChangeSpeed

  forceChangeSpeed: 0.001

  startSettingForce: (sprite, event) =>
    @stopChangingForce()
    @currentlySettingForce = true

  stopSettingForce: (sprite, event) =>
    @currentlySettingForce = false

  settingForce: (event, x, y) ->
    if @currentlySettingForce
      @shotStrength = Math.min 1, Math.max 0, (x + (@cueControlGui.forceStrength.width - @state.game.width) / 2) / @cueControlGui.forceStrength.width
      @updateShotStrengthMask()

  stopChangingForce: () =>
    @shotStrengthChange = 0

  hoverOverControlGui: (sprite, event) =>
    sprite.animations.frame = 1

  leaveControlGui: (sprite, event) =>
    sprite.animations.frame = 0

  pressShootButton: (sprite, event) =>
    @shot.dispatch()

  updateShotStrengthMask: ->
    @shotStrengthMask.clear()
    x = (@state.game.width - @cueControlGui.forceStrength.width) / 2
    width = @cueControlGui.forceStrength.width * @shotStrength
    @shotStrengthMask.drawRect x, 0, width, @state.game.height
