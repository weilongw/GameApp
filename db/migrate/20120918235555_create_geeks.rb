class CreateGeeks < ActiveRecord::Migration
  def change
    create_table :geeks do |t|
      t.string :name
      t.string :email
      t.integer :game_id

      t.timestamps
    end
  end
end
