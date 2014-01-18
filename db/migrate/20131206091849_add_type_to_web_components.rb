class AddTypeToWebComponents < ActiveRecord::Migration
  def change
    add_column :web_components, :type, :string
  end
end
