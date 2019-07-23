require 'test_helper'

class TestControllerTest < ActionController::TestCase
  test "should get tester" do
    get :tester
    assert_response :success
  end

end
