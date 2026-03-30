class User < ActiveRecord::Base
  attr_accessor :reset_token

  has_many :articles, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :highlights, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_save { self.email = email.downcase }
  validates :username, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 105 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }
  has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def create_reset_digest
    self.reset_token = SecureRandom.urlsafe_base64
    update_columns(
      reset_digest: User.digest(reset_token),
      reset_sent_at: Time.zone ? Time.zone.now : Time.now
    )
  end

  def authenticated_reset_token?(token)
    return false if reset_digest.blank?
    BCrypt::Password.new(reset_digest).is_password?(token)
  end

  def password_reset_expired?
    return true if reset_sent_at.blank?
    reset_sent_at < 2.hours.ago
  end

  def avatar_attached?
    avatar_data.present?
  end
end
