class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :username, null: false, limit: 20
      t.datetime :join_date, null: true
      t.integer :rank, null: false
      t.boolean :removed, null: false
      t.string :previous_names, array: true, default: [], null: false
      t.text :comment, null: true

      t.timestamps
    end

    add_index :players, :username, unique: true
  end
end
