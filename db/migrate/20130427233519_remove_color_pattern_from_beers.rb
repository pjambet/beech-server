class RemoveColorPatternFromBeers < ActiveRecord::Migration
  def change
    remove_column :beers, :color_pattern
  end
end
