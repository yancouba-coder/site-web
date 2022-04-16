require "test_helper"

class FormationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get formations_index_url
    assert_response :success
  end
end
