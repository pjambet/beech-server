Beech.Check = DS.Model.extend
  user: DS.belongsTo('Beech.User')
  beer: DS.belongsTo('Beech.Beer')
  created_at: DS.attr('date')
  updated_at: DS.attr('date')
