require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get servicenow" do
    get pages_servicenow_url
    assert_response :success
  end
end
