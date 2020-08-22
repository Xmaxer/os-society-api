class CreateCompetitions < ActiveRecord::Migration[6.0]
  def change
    create_table :competitions do |t|
      t.string :external_url, null: true

      t.timestamps
    end
  end
end
