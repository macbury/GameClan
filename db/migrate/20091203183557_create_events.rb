class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :guild_id
      t.integer :user_id
      t.string :what
      t.text :description
      t.datetime :when
      t.string :where
      t.string :permalink

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
