class AddPasswordDigestToGeeks < ActiveRecord::Migration
  def change
    add_column :geeks, :password_digest, :string
  end
end
