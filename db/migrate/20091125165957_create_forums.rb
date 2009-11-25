class CreateForums < ActiveRecord::Migration
  def self.up
    create_table :forums do |t|
      t.string :name
      t.integer :guild_id
      t.string :permalink
      t.string :description
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :forums
  end
end
