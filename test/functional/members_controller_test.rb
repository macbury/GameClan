require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  def test_create_invalid
    Members.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Members.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to members_url
  end
  
  def test_destroy
    members = Members.first
    delete :destroy, :id => members
    assert_redirected_to members_url
    assert !Members.exists?(members.id)
  end
  
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
end
