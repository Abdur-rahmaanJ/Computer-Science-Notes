require 'test_helper'

class GoodbyeControllerTest < ActionController::TestCase
  test "should get wave" do
    get :wave
    assert_response :success
  end

end
