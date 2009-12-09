require 'test_helper'

class GuildTest < ActiveSupport::TestCase
	fixtures :users, :guilds

	def test_should_be_valid
		assert guilds(:good).valid?
	end
	
	def test_should_become_guild_master
		user = User.first
		guild = create_guild(user)
		assert guild.isGuildMaster?(user)
	end

	def test_should_become_guild_moderator
		user = create_user
		user.save
		guild = create_guild(user)
		guild.assign_moderator(user)
		assert guild.isGuildModerator?(user)
	end
	
	def test_should_become_guild_member
		user = create_user
		user.save
		guild = create_guild(user)
		
		membership = user.memberships.new(:reason => "This guild is Cool!", :game_nick => "Terminator", :stats_link => "http://google.pl/terminator")
    membership.guild_id = guild.id
		membership.save
		
		membership.accept!
		
		assert user.isGuildMember?(guild)
	end
end
