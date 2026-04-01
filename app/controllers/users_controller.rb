class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  def index
    @users = User.includes(:articles, :bookmarks, :highlights).page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    return render('new') unless handle_avatar_upload(@user)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the alpha blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
  end
end

  def edit
  end

  def update
    @user.assign_attributes(user_params)
    return render('edit') unless handle_avatar_upload(@user)

    if @user.save
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user_articles = @user.articles.includes(:user, :categories, :likes, :bookmarks, :comments).page(params[:page]).per(5)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all articles created by user have been deleted"
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  def set_user
    @user = User.find(params[:id])
  end

  def handle_avatar_upload(user)
    return true unless params[:user]

    if params[:user][:remove_avatar] == '1'
      user.avatar_data = nil
    end

    uploaded_avatar = params[:user][:avatar]
    return true unless uploaded_avatar.present?

    unless uploaded_avatar.content_type.to_s.start_with?('image/')
      user.errors.add(:base, 'Profile image must be a valid image file')
      return false
    end

    if uploaded_avatar.size.to_i > 2.megabytes
      user.errors.add(:base, 'Profile image must be 2MB or smaller')
      return false
    end

    encoded_image = Base64.strict_encode64(uploaded_avatar.read)
    user.avatar_data = "data:#{uploaded_avatar.content_type};base64,#{encoded_image}"
    true
  end

  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end 

  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "Only admin users can perform that action"
      redirect_to root_path
    end
  end
  
end
