#= require jasmine-jquery
#= require sinon
#= require_tree ./fixtures
#= require_tree ./helpers
#= require_tree ./matchers
#= require ../../app/assets/javascripts/application
#= require_self
#= require_tree ./

Beech.Store = DS.Store.extend
  revision: 11
  adapter: DS.FixtureAdapter.create
