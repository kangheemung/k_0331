require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get p_index_path
    assert_response :success
  end

  test "should get new" do
    get p_new_path
    assert_response :success
  end

  test "should get show" do
    get p_show_path(@user.id)
    assert_response :success
    post "/articles",
    params: { article: { title: "can create", body: "article successfully." } }
  end

  test "should get edit" do
    get p_edit_path(@user.id)
    assert_response :success
  end

end
