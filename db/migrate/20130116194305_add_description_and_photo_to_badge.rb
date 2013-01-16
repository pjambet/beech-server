class AddDescriptionAndPhotoToBadge < ActiveRecord::Migration
  def change
    add_column :badges, :description, :text
    add_column :badges, :photo, :string
  end
end
