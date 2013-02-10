class AddAcceptedToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :accepted, :boolean
  end
end
