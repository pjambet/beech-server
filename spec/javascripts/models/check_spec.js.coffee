describe 'Beech.Check', ->
  it 'should exists', ->
    expect(Beech.Check).toBeDefined()

  model(Beech.Check)
  .should.belongsTo(Beech.User).as('user')
  .should.belongsTo(Beech.Beer).as('beer')
  .should.have.attribute('created_at', 'date')
  .should.have.attribute('updated_at', 'date')

