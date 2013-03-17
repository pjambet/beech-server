describe 'Beech.Beer', ->
  it 'should exists', ->
    expect(Beech.Beer).toBeDefined()

  model(Beech.Beer)
  .should.haveMany(Beech.Check).as('checks')


