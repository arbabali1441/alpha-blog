require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(username: "commenter", email: "commenter#{SecureRandom.hex(4)}@example.com", password: "password")
    @article = Article.create!(title: "Discussable read", description: "A long enough article description for comment testing.", user: @user)
  end

  test "should require login to comment" do
    post article_comments_path(@article), comment: { content: "Nice read" }
    assert_redirected_to root_path
  end

  test "should create comment" do
    sign_in_as(@user, "password")

    assert_difference 'Comment.count', 1 do
      post article_comments_path(@article), comment: { content: "This really feels like Medium meets Instapaper." }
    end

    assert_redirected_to article_path(@article)
  end

  test "should destroy own comment" do
    sign_in_as(@user, "password")
    comment = Comment.create!(user: @user, article: @article, content: "Saved for later")

    assert_difference 'Comment.count', -1 do
      delete comment_path(comment)
    end

    assert_redirected_to article_path(@article)
  end
end
