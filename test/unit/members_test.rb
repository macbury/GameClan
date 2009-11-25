require 'test_helper'

class MembersTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Members.new.valid?
  end
end
