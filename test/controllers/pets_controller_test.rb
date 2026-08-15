require "test_helper"

class PetsControllerTest < ActionDispatch::IntegrationTest
  test "redirects unauthenticated user to login" do
    get new_pet_url

    assert_redirected_to login_url
  end
end
