class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :event
      t.text :content

      t.timestamps
    end
    add_index :comments, [:user_id, :event_id]
  end
end
