require 'test_helper'

class ModeratorshipsControllerTest < ActionController::TestCase
  def test_create_invalid
    Moderatorship.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Moderatorship.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end
  
  def test_destroy
    moderatorship = Moderatorship.first
    delete :destroy, :id => moderatorship
    assert_redirected_to root_url
    assert !Moderatorship.exists?(moderatorship.id)
  end
end
