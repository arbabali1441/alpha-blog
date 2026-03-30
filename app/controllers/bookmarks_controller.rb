class BookmarksController < ApplicationController
  before_action :require_user

  def index
    @bookmarks = current_user.bookmarks.includes(:article).order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    @article = Article.find(params[:article_id])
    @bookmark = current_user.bookmarks.where(article: @article).first_or_initialize

    if @bookmark.save
      redirect_back(fallback_location: article_path(@article), notice: 'Article bookmarked!')
    else
      redirect_back(fallback_location: article_path(@article), alert: @bookmark.errors.full_messages.to_sentence.presence || 'Unable to bookmark article.')
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.find(params[:id])
    @article = @bookmark.article
    @bookmark.destroy

    redirect_back(fallback_location: article_path(@article), notice: 'Bookmark removed!')
  end
end
