require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(username: "writer", email: "writer#{SecureRandom.hex(4)}@example.com", password: "password")
    @article = Article.create!(title: "Reader mode article", description: "A searchable longform article about offline reading, calm interfaces, and personal libraries.", user: @user)
    @article.tag_list = "reader, offline, library"
    @article.save!
  end

  test "should get show" do
    get article_path(@article)
    assert_response :success
  end

  test "should get reader mode" do
    get reader_article_path(@article)
    assert_response :success
  end

  test "should search articles" do
    get search_articles_path, q: { title_or_description_or_tags_name_cont: "offline" }
    assert_response :success
  end
end
