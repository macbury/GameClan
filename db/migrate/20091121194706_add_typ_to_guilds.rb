class AddTypToGuilds < ActiveRecord::Migration
  def self.up
    add_column :guilds, :typ, :integer, :limit => 1, :default => GT_CLAN
  end

  def self.down
    remove_column :guilds, :typ
  end
end
