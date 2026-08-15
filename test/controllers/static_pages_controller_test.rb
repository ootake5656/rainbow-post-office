require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get root_url

    assert_response :success
    assert_select "h1", text: "虹の麓の郵便局"
  end
end
