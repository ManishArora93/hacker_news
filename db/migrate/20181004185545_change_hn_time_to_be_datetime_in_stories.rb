class ChangeHnTimeToBeDatetimeInStories < ActiveRecord::Migration[5.2]
  def change
  	change_column :stories, :hn_timestamp, :datetime
  end
end
