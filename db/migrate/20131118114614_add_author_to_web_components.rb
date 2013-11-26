class AddAuthorToWebComponents < ActiveRecord::Migration
  def change
    add_column :web_components, :author, :string
  end
end
