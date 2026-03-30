class HighlightsController < ApplicationController
  before_action :require_user

  def create
    @article = Article.find(params[:article_id])
    @highlight = current_user.highlights.build(highlight_params)
    @highlight.article = @article

    if @highlight.save
      redirect_back(fallback_location: reader_article_path(@article), notice: 'Highlight saved.')
    else
      redirect_back(fallback_location: reader_article_path(@article), alert: @highlight.errors.full_messages.to_sentence)
    end
  end

  def destroy
    @highlight = current_user.highlights.find(params[:id])
    article = @highlight.article
    @highlight.destroy

    redirect_back(fallback_location: reader_article_path(article), notice: 'Highlight removed.')
  end

  private

  def highlight_params
    params.require(:highlight).permit(:content, :position)
  end
end
