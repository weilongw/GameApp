class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.string :content
      t.string :comment
      t.integer :geek_id

      t.timestamps
    end
    add_index :plays, [:geek_id, :created_at]

  end
end
