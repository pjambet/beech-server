class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.string :badge_type
      t.text :condition
      t.text :description
      t.integer :quantity
      t.datetime :published_at
      t.timestamps
    end
  end
end
