class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string :title
      t.string :permalink
      t.text :body
      t.integer :user_id
      t.integer :forum_id
      t.boolean :locked, :default => false
      t.boolean :sticky, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
