describe 'Beech.Beer', ->
  it 'should exists', ->
    expect(Beech.Beer).toBeDefined()

  model(Beech.Beer)
  .should.haveMany(Beech.Check).as('checks')
  .should.belongsTo(Beech.BeerColor).as('beerColor')
  .should.have.attribute('id',   'number')
  .should.have.attribute('name', 'string')


