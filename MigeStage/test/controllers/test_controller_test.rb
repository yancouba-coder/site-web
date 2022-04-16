require "test_helper"

class TestControllerTest < ActionDispatch::IntegrationTest
  test "should get affiche" do
    get test_affiche_url
    assert_response :success
  end
end
