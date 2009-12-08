require 'test_helper'

class GuildTest < ActiveSupport::TestCase
	fixtures :guilds, :users

	def test_should_create_guild
		assert guilds(:good).valid?
	end
	
end
