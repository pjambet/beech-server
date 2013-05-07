class AddColorPatternToBeer < ActiveRecord::Migration
  def change
    add_column :beers, :color_pattern, :integer
  end
end
