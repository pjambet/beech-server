describe 'Beech.BeerColor', ->
  it 'should exists', ->
    expect(Beech.BeerColor).toBeDefined()

  model(Beech.BeerColor)
  .should.haveMany(Beech.Beer).as('beers')
  .should.have.attribute('id',   'number')
  .should.have.attribute('name', 'string')
  .should.have.attribute('slug', 'string')
  .should.have.attribute('createdAt', 'date')
  .should.have.attribute('updatedAt', 'date')


