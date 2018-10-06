class CreateReadAndDeleteds < ActiveRecord::Migration[5.2]
  def up
    create_table :read_and_deleteds do |t|
      t.integer :story_id
      t.references :user, foreign_key: true
      t.string :action_type
      t.timestamps
    end
  end

  def down
  	drop_table :read_and_deleteds
  end
end
