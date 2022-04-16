require "test_helper"

class EntreprisesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get entreprises_index_url
    assert_response :success
  end
end
