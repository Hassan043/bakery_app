require "test_helper"

class InventoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get inventories_index_url
    assert_response :success
  end

  test "should get update" do
    get inventories_update_url
    assert_response :success
  end
end
