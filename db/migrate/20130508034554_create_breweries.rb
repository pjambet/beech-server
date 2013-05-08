class CreateBreweries < ActiveRecord::Migration
  def change
    create_table :breweries do |t|
      t.belongs_to :country
      t.string :name
      t.string :address
      t.string :city
      t.string :zipcode
      t.string :phone
      t.string :website
      t.timestamps
    end

    add_column :beers, :brewery_id, :integer
    add_index :beers, :brewery_id
    add_index :breweries, :country_id
  end
end
