require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
  end
    test "invalid signup information" do
      get signup_path
      assert_no_difference 'User.count' do
        post users_path, user: { username:  "",
                                 email: "user@invalid",
                                 password:              "foo",
                                 password_confirmation: "bar" }
        end
        assert_template 'users/new'
        assert_select 'div#<CSS id for error explanation>'
        assert_select 'div.<CSS class for field with error>'
    end
   test "valid signup information" do
    get signup_path
      assert_difference 'User.count', 1 do
        post_via_redirect users_path(@user), user: { username:  "Example User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
      end
      assert_template 'users/show'
      assert is_logged_in?
  end
    
 test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end
  test "login without remembering" do
    # クッキーを保存してログイン
    log_in_as(@user, remember_me: '1')
    delete logout_path
    # クッキーを削除してログイン
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end
