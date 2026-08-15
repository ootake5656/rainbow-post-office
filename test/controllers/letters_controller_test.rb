require "test_helper"

class LettersControllerTest < ActionDispatch::IntegrationTest
  test "redirects unauthenticated user to login" do
    get letters_url

    assert_redirected_to login_url
  end
end
