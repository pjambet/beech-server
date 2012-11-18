class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :eventable
      t.string :eventable_type
      t.timestamps
    end
  end
end
