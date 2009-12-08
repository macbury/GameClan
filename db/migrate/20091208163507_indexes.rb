class Indexes < ActiveRecord::Migration
  def self.up
		add_index 'guilds', 'user_id'
		add_index 'memberships', 'user_id'
		add_index 'memberships', 'guild_id'
		add_index 'topics', 'user_id'
		add_index 'topics', 'forum_id'
		add_index 'topics', 'replied_by_id'
		add_index 'photos', 'user_id'
		add_index 'photos', 'guild_id'
		add_index 'assignments', 'user_id'
		add_index 'assignments', 'role_id'
		add_index 'events', 'guild_id'
		add_index 'events', 'user_id'
		add_index 'movies', 'user_id'
		add_index 'movies', 'guild_id'
		add_index 'moderatorships', 'user_id'
		add_index 'moderatorships', 'guild_id'
		add_index 'forums', 'guild_id'
		add_index 'posts', 'topic_id'
		add_index 'posts', 'user_id'
  end

  def self.down
  end
end
