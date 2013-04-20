BeerServer.Beer = DS.Model.extend({
  name: DS.attr('string'),
  country: DS.attr('string'),
  beer_color: DS.belongsTo('BeerServer.BeerColor')
});
