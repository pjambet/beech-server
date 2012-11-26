class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.belongs_to :follower
      t.belongs_to :followee

      t.timestamps
    end
    add_index :followings, [:follower_id, :followee_id]
  end
end
