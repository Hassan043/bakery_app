require "test_helper"

class Staff::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get staff_orders_index_url
    assert_response :success
  end

  test "should get update" do
    get staff_orders_update_url
    assert_response :success
  end
end
