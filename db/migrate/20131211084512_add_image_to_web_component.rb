class AddImageToWebComponent < ActiveRecord::Migration
  #def self.up
  #  add_attachment :web_components, :image
  #end
  #
  #def self.down
  #  remove_attachment :web_components, :image
  #end

  def change
    #add_column :web_components, :image_file_name, :string
    #add_column :web_components, :image_content_type, :string
    #add_column :web_components, :image_file_size, :string
    add_column :web_components, :image_id, :integer
  end
end
