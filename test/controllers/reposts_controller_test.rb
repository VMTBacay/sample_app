require "test_helper"

class RepostsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get reposts_create_url
    assert_response :success
  end

  test "should get destroy" do
    get reposts_destroy_url
    assert_response :success
  end
end
