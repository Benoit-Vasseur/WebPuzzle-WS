class AddFieldsToWebComponents < ActiveRecord::Migration
  def change
    add_column :web_components, :description, :text
    add_column :web_components, :submitter, :integer
    add_index :web_components, :githubLink, :string
  end
end
