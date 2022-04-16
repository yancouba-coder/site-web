require "test_helper"

class TuteurUniversitairesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get tuteur_universitaires_show_url
    assert_response :success
  end

  test "should get new" do
    get tuteur_universitaires_new_url
    assert_response :success
  end

  test "should get edit" do
    get tuteur_universitaires_edit_url
    assert_response :success
  end
end
