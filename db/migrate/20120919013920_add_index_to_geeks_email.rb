class AddIndexToGeeksEmail < ActiveRecord::Migration
  def change
    add_index :geeks, :email, :unique => true
  end
end
