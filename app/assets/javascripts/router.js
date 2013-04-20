BeerServer.Router.map(function() {
  this.resource('beers', function() {
    this.resource('beer', { path: ':beer_id' });
  });
  this.resource('beer_colors', function() {
    this.resource('beer_color', { path: ':beer_color_id' });
  });
});
