require 'test_helper'

class HighlightsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(username: "highlighter", email: "highlighter#{SecureRandom.hex(4)}@example.com", password: "password")
    @article = Article.create!(title: "Highlightable read", description: "A long enough article description for highlight testing and reader mode coverage.", user: @user)
  end

  test "should require login to highlight" do
    post article_highlights_path(@article), highlight: { content: "reader mode", position: 0 }
    assert_redirected_to root_path
  end

  test "should create highlight" do
    sign_in_as(@user, "password")

    assert_difference 'Highlight.count', 1 do
      post article_highlights_path(@article), highlight: { content: "reader mode coverage", position: 10 }
    end

    assert_redirected_to reader_article_path(@article)
  end

  test "should remove highlight" do
    sign_in_as(@user, "password")
    highlight = Highlight.create!(user: @user, article: @article, content: "highlight me", position: 4)

    assert_difference 'Highlight.count', -1 do
      delete highlight_path(highlight)
    end

    assert_redirected_to reader_article_path(@article)
  end
end
