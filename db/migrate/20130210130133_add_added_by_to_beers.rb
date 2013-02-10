class AddAddedByToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :added_by_id, :integer
    add_index :beers, :added_by_id
  end
end
