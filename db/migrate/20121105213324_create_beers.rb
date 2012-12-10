class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.string :country
      t.belongs_to :beer_color
      t.timestamps
    end
    add_index :beers, :beer_color_id
  end
end
