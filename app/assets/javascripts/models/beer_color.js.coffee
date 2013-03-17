Beech.BeerColor = DS.Model.extend
  id: DS.attr('number')
  name: DS.attr('string')
  slug: DS.attr('string')
  createdAt: DS.attr('date')
  updatedAt: DS.attr('date')
  beers: DS.hasMany('Beech.Beer')
