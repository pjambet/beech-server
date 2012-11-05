class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.belongs_to :beer_type
      t.timestamps
    end
  end
end
