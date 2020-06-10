class AddResetPasswordFieldToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :reset_password, :boolean, default: true
  end
end
