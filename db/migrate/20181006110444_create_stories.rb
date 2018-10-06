class CreateStories < ActiveRecord::Migration[5.2]
  def up
    create_table :stories do |t|
      t.integer :hacker_news_id
      t.text :url
      t.text :title
      t.integer :score
      t.integer :hn_timestamp
      t.integer :descendants
      t.timestamps
    end
  end

  def down
    drop_table :stories
  end
end
