require "test_helper"

class DisponibilitesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get disponibilites_index_url
    assert_response :success
  end
end
