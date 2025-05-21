require "test_helper"

class Staff::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get staff_dashboard_index_url
    assert_response :success
  end
end
