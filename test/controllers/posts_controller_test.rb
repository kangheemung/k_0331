require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @post = posts(:orange)
  end
  test "should get index" do
    get posts_index_path
    assert_response :success
  end

  test "should get new" do
    get posts_new_path
    assert_response :success
  end

  test "should get show" do
    get posts_path(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_posts_path(@post)
    assert_response :success
  end
  test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post post_path, params: { post: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count' do
      delete  posts_destoy_path(@post)
    end
    assert_redirected_to login_url
  end
  test "should redirect destroy for wrong post" do
    log_in_as(users(:michael))
    @post = posts(:ants)
    assert_no_difference 'Post.count' do
      delete posts_destoy_path
    end
    assert_redirected_to root_url
  end



end
