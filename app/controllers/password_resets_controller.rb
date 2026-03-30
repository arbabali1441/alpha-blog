class PasswordResetsController < ApplicationController
  before_action :set_user_from_token, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].to_s.downcase)

    if @user
      @user.create_reset_digest
      PasswordResetMailer.reset_email(@user).deliver_now if should_deliver_reset_email?

      if Rails.env.development?
        flash[:info] = "Reset link: #{edit_password_reset_url(@user.reset_token, email: @user.email)}"
      else
        flash[:success] = "If that email exists in our system, password reset instructions have been generated."
      end
    else
      flash[:warning] = "If that email exists in our system, password reset instructions have been generated."
    end

    redirect_to login_path
  end

  def edit
    return unless @user

    if @user.password_reset_expired?
      flash[:warning] = "That password reset link has expired. Please request a new one."
      redirect_to new_password_reset_path
    end
  end

  def update
    return unless @user

    if @user.password_reset_expired?
      flash[:warning] = "That password reset link has expired. Please request a new one."
      redirect_to new_password_reset_path and return
    end

    if params[:user][:password].blank?
      @user.errors.add(:password, "can't be blank")
      render :edit and return
    end

    if @user.update(password_params)
      @user.update_columns(reset_digest: nil, reset_sent_at: nil)
      session[:user_id] = @user.id
      flash[:success] = "Your password has been reset."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def set_user_from_token
    @user = User.find_by(email: params[:email].to_s.downcase)

    unless @user && @user.authenticated_reset_token?(params[:id])
      flash[:danger] = "That password reset link is invalid."
      redirect_to new_password_reset_path
    end
  end

  def should_deliver_reset_email?
    ActionMailer::Base.delivery_method != :test
  end
end
