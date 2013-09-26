class AddNameToWebComponents < ActiveRecord::Migration
  def change
    add_column :web_components, :name, :string
  end
end
