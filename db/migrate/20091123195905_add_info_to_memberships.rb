class AddInfoToMemberships < ActiveRecord::Migration
  def self.up
    add_column :memberships, :reason, :text
    add_column :memberships, :game_nick, :string
    add_column :memberships, :stats_link, :string
    
    add_column :guilds, :guild_join_text, :text, :default => "Napisz pokrótce, dlaczego akurat chciałbyś dołączyć do naszej gildii/klanu?"
  end

  def self.down
    remove_column :memberships, :stats_link
    remove_column :memberships, :game_nick
    remove_column :memberships, :reason
    remove_column :guilds, :guild_join_text
  end
end
