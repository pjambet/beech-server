BeerServer.BeersRoute = Ember.Route.extend({
  model: function() {
    return BeerServer.Beer.find();
  }
});
