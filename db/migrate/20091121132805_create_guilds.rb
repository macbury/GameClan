class CreateGuilds < ActiveRecord::Migration
  def self.up
    create_table :guilds do |t|
      t.string :name
      t.string :permalink
      t.string :game
      t.string :server
      t.text :about
      
      t.integer :background_color, :default => 0
      
      t.string :background_file_name
      t.string :background_content_type
      t.string :background_file_size
      t.string :background_updated_at
      
      t.string :logo_file_name
      t.string :logo_content_type
      t.string :logo_file_size
      t.string :logo_updated_at
      
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :guilds
  end
end
