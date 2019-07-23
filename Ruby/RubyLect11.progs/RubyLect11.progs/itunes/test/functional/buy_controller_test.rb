require 'test_helper'

class BuyControllerTest < ActionController::TestCase
  test "should get songo" do
    get :songo
    assert_response :success
  end

end
