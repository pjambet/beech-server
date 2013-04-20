BeerServer.Store = DS.Store.extend({
  revision: 11,
  adapter: DS.RESTAdapter.create({
    namespace: 'api/'
  })
});

// DS.RESTAdapter.configure('App.BeerColor', {
//   sideloadAs: 'beer_colors' 
// });
