class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :title
      t.string :permalink
      
      t.text :description
      t.integer :user_id
      t.integer :guild_id
      t.integer :duration, :default => 0
      
      t.boolean :processing, :default => false
      
      t.string :clip_file_name
      t.string :clip_content_type
      t.integer :clip_file_size
      t.datetime :clip_updated_at
      
      t.string :video_file_name
      t.string :video_content_type
      t.integer :video_file_size
      t.datetime :video_updated_at
      
      t.string :preview_file_name
      t.string :preview_content_type
      t.integer :preview_file_size
      t.datetime :preview_updated_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :movies
  end
end
