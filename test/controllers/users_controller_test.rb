require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get account_settings" do
    get :account_settings
    assert_response :success
  end

end
