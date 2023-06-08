ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!


class ActiveSupport::TestCase

 fixtures :all
 include ApplicationHelper
  # テストユーザーがログイン中の場合にtrueを返す
  def is_logged_in?
    !session[:user_id].nil?
  end
# テストユーザーとしてログインする
  def log_in_as(user)
    session[:user_id] = user.id
  end

  # テストユーザーとしてログインする
  def log_in_as(user, options = {})
    password    = options[:password]    || 'password'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      post login_create_path(user.id), params: {session:{ email: user.email,
                                  password:    password,
                                  remember_me: remember_me }}
    else
      session[:user_id] = user.id
    end
  end
end

class ActionDispatch::IntegrationTest
    def log_in_as(user, password: 'password', remember_me: '1')
      post login_create_path, params:  {session:{ email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
    end
end
 private

  # 統合テスト内ではtrueを返す
  def integration_test?
    defined?(post_via_redirect)
  end

