class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.integer :hacker_news_id
      t.text :url
      t.text :title
      t.integer :score
      t.time :hn_timestamp

      t.timestamps
    end
  end
end
