class CreateCompetitionRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :competition_records do |t|
      t.references :player, null: true, foreign_key: true
      t.bigint :xp, null: false
      t.integer :position, null: false
      t.references :competition, null: false, foreign_key: true

      t.timestamps
    end

    add_index :competition_records, [:position, :competition_id], unique: true
  end
end
