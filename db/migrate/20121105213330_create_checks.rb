class CreateChecks < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.belongs_to :user, :beer
      t.timestamps
    end
    add_index :checks, [:user_id, :beer_id]
  end
end
