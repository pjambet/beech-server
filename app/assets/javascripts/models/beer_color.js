BeerServer.BeerColor = DS.Model.extend({
  name: DS.attr('string'),
  beers: DS.hasMany('BeerServer.Beer')
});
