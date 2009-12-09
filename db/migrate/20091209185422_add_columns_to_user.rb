class AddColumnsToUser < ActiveRecord::Migration
  def self.up
		add_column :users, :gg, :integer
		add_column :users, :jabber, :string
		
		add_column :users, :notification_posts, :boolean, :default => true
		add_column :users, :notification_photos, :boolean, :default => true
		add_column :users, :notification_movies, :boolean, :default => true
		add_column :users, :notification_events, :boolean, :default => true
  end

  def self.down
  end
end
