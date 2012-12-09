class Roles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :roles, :name

    create_table :memberships do |t|
      t.belongs_to :role, :user, null: false
    end
    add_index :memberships, [:role_id, :user_id]
  end

end
