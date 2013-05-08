class AddLatLngToBreweries < ActiveRecord::Migration
  def change
    add_column :breweries, :lat, :float
    add_column :breweries, :lng, :float
  end
end
