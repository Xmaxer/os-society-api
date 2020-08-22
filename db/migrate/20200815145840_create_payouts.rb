class CreatePayouts < ActiveRecord::Migration[6.0]
  def change
    create_table :payouts do |t|
      t.references :paid_by, null: false, foreign_key: {to_table: :users}
      t.integer :amount, null: false
      t.references :competition_record, null: false, foreign_key: true

      t.timestamps
    end

    add_index :payouts, :competition_record_id, unique: true, name: 'unique_index_payouts_on_competition_record_id'
  end
end
