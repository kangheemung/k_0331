require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
    def setup
      ActionMailer::Base.deliveries.clear
    end

  test"valid signup information" do
      get users_new_path
      assert_difference 'User.count', 1 do
        post signup_create_path, params:{ user: { username:  "Example User",
                                              email: "user@example.com",
                                              password:              "password",
                                              password_confirmation: "password" }}
      end

      #assert_template 'users/show'
      #assert_not flash.FILL_IN
  end

    test "invalid signup information" do
      get users_new_path
      assert_no_difference 'User.count'do
        post  signup_create_path params:{ user: { username:  "",
                                 email: "user@invalid",
                                 password:              "foo",
                                 password_confirmation: "bar" }}
        end
        assert_template 'users/new'
        assert_select 'div#error_explanation'   
        assert_select 'div.field_with_errors'
          
    end
    
     test "valid signup information with account activation" do
      get users_new_path
      assert_difference 'User.count', 1 do
        post signup_create_path, params:{  user: { username:  "Example User",
                                           email: "user@example.com",
                                           password:              "password",
                                           password_confirmation: "password" }} 
        end
        
       assert_equal 1, ActionMailer::Base.deliveries.size
        user = assigns(:user)
        assert_not user.activated?
     # 有効化していない状態でログインしてみる
        log_in_as(user)
        assert_not is_logged_in?
        # 有効化トークンが不正な場合
        get edit_account_activation_path("invalid token")
        assert_not is_logged_in?
        # トークンは正しいがメールアドレスが無効な場合
        get edit_account_activation_path(user.activation_token, email: 'wrong')
        assert_not is_logged_in?
        # 有効化トークンが正しい場合
        get edit_account_activation_path(user.activation_token, email: user.email)
        assert user.reload.activated?
        follow_redirect!
        assert_template 'users/show'
        assert is_logged_in?
  end

end
