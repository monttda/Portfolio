class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.integer :user_id
      t.string :text
      t.string :url
      t.integer :points

      t.timestamps
    end
  end
end
