class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy, :reader]
  before_action :require_user, except: [:index, :show, :reader, :search]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    load_article_index
  end

  def search
    load_article_index
    render :search
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def show
    @article.increment_view_count!
    prepare_article_page
  end

  def reader
    @article.increment_view_count!
    prepare_article_page
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :tag_list, category_ids: [])
  end

  def load_article_index
    @q = Article.includes(:user, :categories, :tags).recent_first.ransack(params[:q])
    @articles = @q.result(distinct: true).page(params[:page]).per(5)
    @trending_articles = Article.trending(5)
  end

  def prepare_article_page
    @comment = Comment.new
    @highlight = Highlight.new
    @article_highlights = logged_in? ? @article.highlights_for(current_user) : []
    @recommended_articles = Article.recommended_for(current_user, @article, 4)
  end

  def require_same_user
    if current_user != @article.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own articles"
      redirect_to root_path
    end
  end

end
