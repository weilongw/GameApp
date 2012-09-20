class AddRememberTokenToGeeks < ActiveRecord::Migration
  def change
    add_column :geeks, :remember_token, :string
    add_index :geeks, :remember_token
  end
end
