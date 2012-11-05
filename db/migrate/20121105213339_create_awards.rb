class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.belongs_to :user, :badge
      t.timestamps
    end
  end
end
