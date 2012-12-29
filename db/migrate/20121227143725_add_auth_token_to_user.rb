class AddAuthTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :string
  end
end
