require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user       = users(:michael)
    @other_user = users(:archer)
  end
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end
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
