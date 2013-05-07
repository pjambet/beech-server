class TranslateBadgeDescription < ActiveRecord::Migration
  def change
    change_table :badges do |t|
      t.rename :description, :description_fr
      t.text :description_en
    end
  end
end
