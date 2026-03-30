class LikesController < ApplicationController
  before_action :require_user

  def create
    @article = Article.find(params[:article_id])
    @like = current_user.likes.where(article: @article).first_or_initialize

    if @like.save
      redirect_back(fallback_location: article_path(@article), notice: 'Article liked!')
    else
      redirect_back(fallback_location: article_path(@article), alert: @like.errors.full_messages.to_sentence.presence || 'Unable to like article.')
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @article = @like.article
    @like.destroy

    redirect_back(fallback_location: article_path(@article), notice: 'Like removed!')
  end
end
