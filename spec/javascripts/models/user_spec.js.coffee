describe 'Beech.User', ->
  it 'should exists', ->
    expect(Beech.User).toBeDefined()

  model(Beech.User)
  .should.haveMany(Beech.Check).as('checks')

