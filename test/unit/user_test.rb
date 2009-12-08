require 'test_helper'

class UserTest < ActiveSupport::TestCase
	
  def test_should_register
		user = create_user
		puts user.errors.full_messages.join(', ')
    assert user.errors.empty?
  end

	def test_should_show_bad_email
    assert create_user( :email => "someShitHere" ).errors.on(:email)
  end

	def test_should_show_bad_password_confirmation
    assert create_user( :password => "Booooo!", :password_confirmation => "another shit" ).errors.on(:password)
  end

	def test_should_show_not_accepted_terms_of_service
    assert create_user(:terms_of_service => false).errors.on(:terms_of_service)
  end

	protected
	  def create_user(options = {})
	    record = User.new({ :login => 'dude', :email => 'dude@example.com', :password => 'this_is_booring_password', :password_confirmation => 'this_is_booring_password', "terms_of_service"=>"1" }.merge(options))
	    record.save
	    record
	  end
end
