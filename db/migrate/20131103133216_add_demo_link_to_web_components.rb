class AddDemoLinkToWebComponents < ActiveRecord::Migration
  def change
    add_column :web_components, :demoLink, :string
  end
end
