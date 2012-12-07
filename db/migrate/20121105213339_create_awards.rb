class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.belongs_to :user, :badge
      t.timestamps
    end
    add_index :awards, [:user_id, :badge_id]
  end
end
