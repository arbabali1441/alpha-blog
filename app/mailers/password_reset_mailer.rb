class PasswordResetMailer < ActionMailer::Base
  default from: 'no-reply@alpha-blog.local'

  def reset_email(user)
    @user = user
    @reset_url = edit_password_reset_url(user.reset_token, email: user.email)
    mail(to: @user.email, subject: 'Reset your Alpha Blog password')
  end
end
