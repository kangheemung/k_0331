require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_index_path
    assert_response :success
  end

  test "should get new" do
    get users_new_path
    assert_response :success
  end

  test "should get show" do
    get users_show_path
    assert_response :success
  end

  test "should get edit" do
    get users_edit_path
    assert_response :success
  end

end
