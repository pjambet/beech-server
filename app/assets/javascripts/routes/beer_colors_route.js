BeerServer.BeerColorsRoute = Ember.Route.extend({
  model: function() {
    return BeerServer.BeerColors.find();
  }
});
