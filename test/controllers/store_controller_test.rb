require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url

    assert_response :success
    assert_select "h1", "Your Pragmatic Catalog"
    assert_select "h2", "Ruby"
    assert_select "div", /Ruby book \$9\.99/
  end
end