class AddTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :github_token, :string
    add_index :users, :github_token, :unique => true
  end
end
