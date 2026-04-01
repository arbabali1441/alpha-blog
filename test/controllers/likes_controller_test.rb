require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(username: "liker", email: "liker#{SecureRandom.hex(4)}@example.com", password: "password")
    @article = Article.create!(title: "Likeable read", description: "A long enough article description for like testing.", user: @user)
  end

  test "should require login to like" do
    post article_likes_path(@article)
    assert_redirected_to root_path
  end

  test "should create like" do
    sign_in_as(@user, "password")

    assert_difference 'Like.count', 1 do
      post article_likes_path(@article)
    end

    assert_redirected_to article_path(@article)
  end

  test "should remove like" do
    sign_in_as(@user, "password")
    like = Like.create!(user: @user, article: @article)

    assert_difference 'Like.count', -1 do
      delete like_path(like)
    end

    assert_redirected_to article_path(@article)
  end
end
