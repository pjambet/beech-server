Beech.Check = DS.Model.extend
  user: DS.belongsTo('Beech.User')
  beer: DS.belongsTo('Beech.Beer')
  createdAt: DS.attr('date')
  updatedAt: DS.attr('date')
