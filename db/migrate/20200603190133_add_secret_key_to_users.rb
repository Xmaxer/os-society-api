class AddSecretKeyToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :secret_key, :string, null: false
  end
end
