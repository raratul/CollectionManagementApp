require "application_system_test_case"

class UserCollectionsTest < ApplicationSystemTestCase
  setup do
    @user_collection = user_collections(:one)
  end

  test "visiting the index" do
    visit user_collections_url
    assert_selector "h1", text: "User collections"
  end

  test "should create user collection" do
    visit user_collections_url
    click_on "New user collection"

    fill_in "Collection", with: @user_collection.collection_id
    fill_in "User", with: @user_collection.user_id
    click_on "Create User collection"

    assert_text "User collection was successfully created"
    click_on "Back"
  end

  test "should update User collection" do
    visit user_collection_url(@user_collection)
    click_on "Edit this user collection", match: :first

    fill_in "Collection", with: @user_collection.collection_id
    fill_in "User", with: @user_collection.user_id
    click_on "Update User collection"

    assert_text "User collection was successfully updated"
    click_on "Back"
  end

  test "should destroy User collection" do
    visit user_collection_url(@user_collection)
    click_on "Destroy this user collection", match: :first

    assert_text "User collection was successfully destroyed"
  end
end
