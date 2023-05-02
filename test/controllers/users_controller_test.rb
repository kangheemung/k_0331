require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user       = users(:michael)
    @other_user = users(:archer)
  end
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get users_edit_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end
   test "should redirect index when not logged in" do
    get users_path

    assert_redirected_to login_url
  end
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
                                    user: { password:              （コードを書き込む）,
                                            password_confirmation: （コードを書き込む）,
                                            admin: （コードを書き込む） } }
    assert_not @other_user.（コードを書き込む）.admin?
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
    get users_show_path(@user.id)
    assert_response :success
  end

  test "should get edit" do
    session[:user_id] = @user.id 
    get users_edit_path params: { id: @user.id }
  
    assert_response :success
  end

end
