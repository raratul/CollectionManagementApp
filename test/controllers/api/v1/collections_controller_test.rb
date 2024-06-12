require "test_helper"

class Api::V1::CollectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_collections_index_url
    assert_response :success
  end
end
