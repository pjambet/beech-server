class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.string :hook_model
      t.string :type
      t.text :condition
      t.timestamps
    end
  end
end
