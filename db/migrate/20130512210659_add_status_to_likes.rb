class AddStatusToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :status, :boolean
  end
end
