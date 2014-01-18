class CreateUploads < ActiveRecord::Migration
  def self.up
    add_attachment :uploads, :file
  end

  def self.down
    remove_attachment :uploads, :file
  end

  def change
    create_table :uploads do |t|
      add_column :uploads, :file_file_name, :string
      add_column :uploads, :file_content_type, :string
      add_column :uploads, :file_file_size, :string

      t.timestamps
    end
  end
end
