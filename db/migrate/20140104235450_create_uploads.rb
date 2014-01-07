class CreateUploads < ActiveRecord::Migration
  def self.up
    add_attachment :uploads, :file
  end

  def self.down
    remove_attachment :uploads, :file
  end

  def change
    create_table :uploads do |t|
      t.string :file_name
      t.string :file_content_type
      t.string :file_size

      t.timestamps
    end
  end
end
