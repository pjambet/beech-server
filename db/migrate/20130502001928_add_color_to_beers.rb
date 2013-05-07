class AddColorToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :font_color, :string
    add_column :beers, :background_color, :string
  end
end
