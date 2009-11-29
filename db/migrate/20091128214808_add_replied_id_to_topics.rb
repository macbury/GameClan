class AddRepliedIdToTopics < ActiveRecord::Migration
  def self.up
    add_column :topics, :replied_by_id, :integer

  end

  def self.down
    remove_column :topics, :replied_by_id
  end
end
