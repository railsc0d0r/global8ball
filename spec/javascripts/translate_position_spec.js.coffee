#= require game/game

describe 'Position translation', ->

  first = left: -100, top: -200, right: 200, bottom: 300
  second = left: 200, top: -500, right: 1100, bottom: 500
  translate = new Game.PositionTranslation first, second

  it 'translates the top-left position', ->
    expect(translate.to x: -100, y: -200).toEqual x: 200, y: -500

  it 'translates the bottom-right position', ->
    expect(translate.to x: 200, y: 300).toEqual x: 1100, y: 500

  it 'translates a position outside', ->
    expect(translate.to x: -150, y: -300).toEqual x: 50, y: -700

  it 'translates a position inside', ->
    expect(translate.to x: 0, y: 100).toEqual x: 500, y: 100

  it 'reverse-translates the top-left position', ->
    expect(translate.from x: 200, y: -500).toEqual x: -100, y: -200

  it 'reverse-translates the bottom-right position', ->
    expect(translate.from x: 1100, y: 500).toEqual x: 200, y: 300

  it 'reverse-translates a position outside', ->
    expect(translate.from x: 1400, y: 700).toEqual x: 300, y: 400

  it 'reverse-translates a position inside', ->
    expect(translate.from x: 800, y: 300).toEqual x: 100, y: 200
