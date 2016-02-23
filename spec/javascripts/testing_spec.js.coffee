# Just to test if testing works ;-)
describe "Testing", ->
  it "works", ->
    assert.equal 1+5, 6
    expect(2+4).to.equal 6
    (3+3).should.equal 6
