class CreateWebComponents < ActiveRecord::Migration
  def self.up
    create_table :web_components do |t|
      t.string   "name"
      t.text     "description"
      t.string   "githubLink"
      t.integer  "submitter"
      t.string   "demoLink"
      t.string   "author"
      t.string   "type"
      t.integer  "imageId"

      t.timestamps
    end
  end
end
