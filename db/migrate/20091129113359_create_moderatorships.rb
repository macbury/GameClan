class CreateModeratorships < ActiveRecord::Migration
  def self.up
    create_table :moderatorships do |t|
      t.integer :user_id
      t.integer :guild_id

      t.timestamps
    end
  end

  def self.down
    drop_table :moderatorships
  end
end
