class AddAdminToGeeks < ActiveRecord::Migration
  def change
    add_column :geeks, :admin, :boolean, default: false
  end
end
