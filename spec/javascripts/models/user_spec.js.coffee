describe 'Beech.User', ->
  it 'should exists', ->
    expect(Beech.User).toBeDefined()

  model(Beech.User)
  .should.haveMany(Beech.Check).as('checks')
  .should.have.attribute('id',                'number')
  .should.have.attribute('email',             'string')
  .should.have.attribute('nickname',          'string')
  .should.have.attribute('avatarUrl',        'string')
  .should.have.attribute('alreadyFollowing', 'boolean')

