class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads do |t|
      #t.string   "file_file_name"
      #t.string   "file_content_type"
      #t.string   "file_file_size"

      t.timestamps
    end
  end
end
