class AddLatLngToCheck < ActiveRecord::Migration
  def change
    add_column :checks, :lat, :float
    add_column :checks, :lng, :float
  end
end
