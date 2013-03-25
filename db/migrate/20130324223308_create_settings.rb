class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.belongs_to :user
      t.hstore :properties
      t.timestamps
    end
  end
end
