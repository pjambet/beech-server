class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :notificable_type
      t.integer :notificable_id
      t.belongs_to :user # This might not be needed, but just in case
      t.timestamps
    end
    add_index :notifications, :user_id
    add_index :notifications, :notificable_id
  end
end
