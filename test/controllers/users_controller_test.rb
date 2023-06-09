require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  
  end
  test "should redirect index when not logged in" do
    get users_index_path
    assert_redirected_to login_url
  end
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end
  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch users_path(@user), params: { user: { username: @user.username,
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
    get user_path(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_path(@user.id)
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect update when not logged in" do
    patch users_path(@user), params: { user: { username: @user.username,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url

  end


  
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
       delete user_destroy_path(@user)
    end
    assert_redirected_to login_url
  end
  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
       delete user_destroy_path(@user)
    end
    assert_redirected_to root_url
  end
 


  
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch users_path(@other_user), params: {
                        user: { password: @other_user.password,
                            password_confirmation: @other_user.password,
                            admin: true } }
    assert_not @other_user.reload.admin?
  end

end
