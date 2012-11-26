class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :eventable
      t.belongs_to :user
      t.string :eventable_type
      t.timestamps
    end
    add_index :events, :eventable_id
    add_index :events, :user_id
  end
end
