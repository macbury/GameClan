class RemoveNameFromPhotos < ActiveRecord::Migration
  def self.up
	  remove_column :photos, :name
    remove_column :photos, :permalink
  end

  def self.down
  end
end
