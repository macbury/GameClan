class AddAvatarToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :avatar_file_name,    :string
    add_column :users, :avatar_content_type, :string
    add_column :users, :avatar_file_size,    :integer
    add_column :users, :avatar_updated_at,   :datetime
    
    add_column :users, :full_name,   :string
    add_column :users, :www,   :string
    
  end

  def self.down
    remove_column :users, :avatar_file_name
    remove_column :users, :avatar_content_type
    remove_column :users, :avatar_file_size
    remove_column :users, :avatar_updated_at
    remove_column :users, :full_name
    remove_column :users, :www
  end
end
