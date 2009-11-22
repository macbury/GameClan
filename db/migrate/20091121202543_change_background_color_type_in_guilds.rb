class ChangeBackgroundColorTypeInGuilds < ActiveRecord::Migration
  def self.up
    change_column :guilds, :background_color, :string, :default => '000000'
  end

  def self.down
  end
end
