require 'test_helper'

class OtherControllerTest < ActionController::TestCase
  test "should get name" do
    get :name
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get change" do
    get :change
    assert_response :success
  end

  test "should get quote" do
    get :quote
    assert_response :success
  end

end
