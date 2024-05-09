require "test_helper"

class UserCollectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_collection = user_collections(:one)
  end

  test "should get index" do
    get user_collections_url
    assert_response :success
  end

  test "should get new" do
    get new_user_collection_url
    assert_response :success
  end

  test "should create user_collection" do
    assert_difference("UserCollection.count") do
      post user_collections_url, params: { user_collection: { collection_id: @user_collection.collection_id, user_id: @user_collection.user_id } }
    end

    assert_redirected_to user_collection_url(UserCollection.last)
  end

  test "should show user_collection" do
    get user_collection_url(@user_collection)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_collection_url(@user_collection)
    assert_response :success
  end

  test "should update user_collection" do
    patch user_collection_url(@user_collection), params: { user_collection: { collection_id: @user_collection.collection_id, user_id: @user_collection.user_id } }
    assert_redirected_to user_collection_url(@user_collection)
  end

  test "should destroy user_collection" do
    assert_difference("UserCollection.count", -1) do
      delete user_collection_url(@user_collection)
    end

    assert_redirected_to user_collections_url
  end
end
