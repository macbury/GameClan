require 'test_helper'

class ForumTest < ActiveSupport::TestCase
  # Replace this with your real tests.
	fixtures :forums

	def test_should_be_valid
		assert forums(:good).valid?
	end

	def test_should_show_bad_name
		forum = Forum.create :name => "qwertyuiopasdfghjklzxcvbnmqwerttsadsadassxcnkjdsn", :description => "valid"
		assert forum.errors.on(:name)
	end

	def test_should_show_bad_description
		forum = Forum.create :name => "qwertyuiopasdfghjklzxcvbnmqwerttsadsadassxcnkjdsn", :description => "qwertyuiopasdfghjklzxcvbnmqwerttsadsadassxcnkjdsnqwertyuiopasdfghjklzxcvbnmqwerttsadsadassxcnkjdsnqwertyuiopasdfghjklzxcvbnmqwerttsadsadassxcnkjdsnqwertyuiopasdfghjklzxcvbnmqwerttsadsadassxcnkjdsnqwertyuiopasdfghjklzxcvbnmqwerttsadsadassxcnkjdsnqwertyuiopasdfghjklzxcvbnmqwerttsadsadassxcnkjdsnqwertyuiopasdfghjklzxcvbnmqwerttsadsadassxcnkjdsnqwertyuiopasdfghjklzxcvbnmqwerttsadsadassxcnkjdsnqwertyuiopasdfghjklzxcvbnmqwerttsadsadassxcnkjdsn"
		assert forum.errors.on(:description)
	end

end
