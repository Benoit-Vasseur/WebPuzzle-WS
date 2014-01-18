class CreateWebComponents < ActiveRecord::Migration
  def change
    create_table :web_components do |t|
      add_column :web_components, :name, :string
      add_column :web_components, :description, :text
      add_column :web_components, :githubLink, :string
      add_column :web_components, :submitter, :integer
      add_column :web_components, :demoLink, :string
      add_column :web_components, :author, :string
      add_column :web_components, :type, :string
      add_column :web_components, :imageId, :integer

      t.timestamps
    end
  end
end
