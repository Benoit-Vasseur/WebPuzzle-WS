class AddFieldsToWebComponents < ActiveRecord::Migration
  def change
    add_column :web_components, :imageLink, :string
    add_column :web_components, :description, :text
    add_column :web_components, :githubLink, :string
    add_column :web_components, :submitter, :integer
  end
end
