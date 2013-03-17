Beech.Beer = DS.Model.extend
  id: DS.attr('number')
  name: DS.attr('string')
  checks: DS.hasMany('Beech.Check')
  beerColor: DS.belongsTo('Beech.BeerColor')
