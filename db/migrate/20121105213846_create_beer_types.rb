class CreateBeerTypes < ActiveRecord::Migration
  def change
    create_table :beer_types do |t|
      t.string :name
      t.timestamps
    end
  end
end
