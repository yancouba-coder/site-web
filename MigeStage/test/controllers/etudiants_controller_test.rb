require "test_helper"

class EtudiantsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get etudiants_index_url
    assert_response :success
  end
end
