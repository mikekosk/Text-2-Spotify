class AddSpotifyhashToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :account_hash, :text
  end
end
