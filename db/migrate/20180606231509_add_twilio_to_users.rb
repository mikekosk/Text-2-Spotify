class AddTwilioToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :account_sid, :string
    add_column :users, :auth_token, :string
    add_column :users, :phone, :string
  end
end
