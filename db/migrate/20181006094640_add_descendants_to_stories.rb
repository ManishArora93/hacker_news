class AddDescendantsToStories < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :descendants, :integer
  end
end
