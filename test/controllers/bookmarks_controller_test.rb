require 'test_helper'

class BookmarksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(username: "bookmarker", email: "bookmarker#{SecureRandom.hex(4)}@example.com", password: "password")
    @article = Article.create!(title: "Saved reading", description: "A long enough article description for bookmark testing.", user: @user)
  end

  test "should require login for reading list" do
    get reading_list_path
    assert_redirected_to root_path
  end

  test "should create bookmark" do
    sign_in_as(@user, "password")

    assert_difference 'Bookmark.count', 1 do
      post article_bookmarks_path(@article)
    end

    assert_redirected_to article_path(@article)
  end

  test "should remove bookmark" do
    sign_in_as(@user, "password")
    bookmark = Bookmark.create!(user: @user, article: @article)

    assert_difference 'Bookmark.count', -1 do
      delete bookmark_path(bookmark)
    end

    assert_redirected_to article_path(@article)
  end
end
