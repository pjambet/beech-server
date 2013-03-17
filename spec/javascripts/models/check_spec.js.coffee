describe 'Beech.Check', ->
  it 'should exists', ->
    expect(Beech.Check).toBeDefined()

  model(Beech.Check)
  .should.belongsTo(Beech.User).as('user')
  .should.belongsTo(Beech.Beer).as('beer')
  .should.have.attribute('createdAt', 'date')
  .should.have.attribute('updatedAt', 'date')

