BeerServer.ApplicationRoute = Ember.Route.extend({
  model: function() {
    return { 
      name: 'Beech',
      timer: 0
    };
  },
});
