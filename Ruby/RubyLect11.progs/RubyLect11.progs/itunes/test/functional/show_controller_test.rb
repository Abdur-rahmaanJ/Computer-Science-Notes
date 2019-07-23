require 'test_helper'

class ShowControllerTest < ActionController::TestCase
  test "should get list_song" do
    get :list_song
    assert_response :success
  end

  test "should get album" do
    get :album
    assert_response :success
  end

  test "should get actor" do
    get :actor
    assert_response :success
  end

end
