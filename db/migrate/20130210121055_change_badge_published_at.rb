class ChangeBadgePublishedAt < ActiveRecord::Migration
  def change
    remove_column :badges, :published_at
    add_column :badges, :published, :boolean
  end

end
