class Article < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  has_many :bookmarks, dependent: :destroy
  has_many :highlights, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
  validates :user_id, presence: true

  scope :recent_first, -> { order(created_at: :desc) }

  def self.trending(limit = 5)
    includes(:likes, :bookmarks).to_a.sort_by do |article|
      [
        -(article.view_count || 0),
        -article.likes.size,
        -article.bookmarks.size,
        -(article.created_at.to_i)
      ]
    end.first(limit)
  end

  def self.recommended_for(user, excluded_article = nil, limit = 4)
    scope = recent_first
    scope = scope.where.not(id: excluded_article.id) if excluded_article
    scope = scope.where.not(user_id: user.id) if user

    scope.includes(:user, :likes, :bookmarks).to_a.sort_by do |article|
      [-(article.likes.size + article.bookmarks.size), -(article.view_count || 0), -(article.created_at.to_i)]
    end.first(limit)
  end

  # Track views
  def increment_view_count!
    self.view_count ||= 0
    self.view_count += 1
    save(validate: false)
  end

  # Check if article is bookmarked by user
  def bookmarked_by?(user)
    return false unless user
    bookmarks.where(user: user).exists?
  end

  # Check if article is liked by user
  def liked_by?(user)
    return false unless user
    likes.where(user: user).exists?
  end

  def bookmark_for(user)
    return nil unless user
    bookmarks.where(user: user).first
  end

  def like_for(user)
    return nil unless user
    likes.where(user: user).first
  end

  def reading_time_minutes
    [(description.to_s.split.size / 200.0).ceil, 1].max
  end

  def highlights_for(user)
    return Highlight.none unless user
    highlights.where(user: user).order(created_at: :desc)
  end
end
