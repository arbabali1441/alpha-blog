class CommentsController < ApplicationController
  before_action :require_user

  def create
    @article = Article.find(params[:article_id])
    @comment = current_user.comments.build(comment_params)
    @comment.article = @article

    if @comment.save
      redirect_back(fallback_location: article_path(@article), notice: 'Comment posted.')
    else
      redirect_back(fallback_location: article_path(@article), alert: @comment.errors.full_messages.to_sentence)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    article = @comment.article

    unless @comment.user == current_user || current_user.admin?
      redirect_back(fallback_location: article_path(article), alert: 'You can only remove your own comments.') and return
    end

    @comment.destroy
    redirect_back(fallback_location: article_path(article), notice: 'Comment removed.')
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
