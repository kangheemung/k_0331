require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # 
  def setup
    @user = users(:michael)
  end

  test "post interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=text_area]'
    # 無効な送信
    assert_no_difference 'Post.count' do
      post post_path,  post: { content: "" } 
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    content = "This post really ties the room together"
    assert_difference 'Post.count', 1 do
      post post_path,post: { content: content,picture: true } 
    end
    
   assert Post.last.picture?
    follow_redirect!
    assert_match content, response.body
    # 投稿を削除する
    assert_select 'a', text: 'delete'
    first_post = @user.posts.paginate(page: 1).first
    assert_difference 'Post.count', -1 do
      delete post_destroy_path(first_post)
    end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
  get users_index_path(users(:archer))
  assert_select 'a', text: 'delete', count: 0
  end
end
