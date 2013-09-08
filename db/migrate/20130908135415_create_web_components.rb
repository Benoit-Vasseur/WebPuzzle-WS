class CreateWebComponents < ActiveRecord::Migration
  def change
    create_table :web_components do |t|

      t.timestamps
    end
  end
end
