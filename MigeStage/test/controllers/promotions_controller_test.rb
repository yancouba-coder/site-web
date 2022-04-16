require "test_helper"

class PromotionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get promotions_index_url
    assert_response :success
  end
end
