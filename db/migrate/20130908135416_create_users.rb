class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   "provider"
      t.string   "uid"
      t.string   "name"
      t.string   "avatar_url"
      t.string   "github_token"
      t.string   "email"

      t.timestamps
    end

    add_index :users, :github_token, :unique => true
  end
end
