class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.belongs_to :event
      t.belongs_to :user
      t.timestamps
    end
  end
end
