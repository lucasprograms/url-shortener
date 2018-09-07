class ShortenedUrl < ApplicationRecord
  validates :short_url, uniqueness: true
  validates :long_url, presence: true
  validates :user_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: 'Visit'

  has_many :visitors,
    through: :visits,
    source: :user

  has_many :distinct_visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user

  def ShortenedUrl.random_code
    code = SecureRandom.urlsafe_base64

    ShortenedUrl.exists?(short_url: code) ? ShortenedUrl.random_code : code
  end

  def ShortenedUrl.createShortUrl(user, url)
    ShortenedUrl.create!(long_url: url, user_id: user.id, short_url: random_code)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    distinct_visitors.count
  end

  def num_recent_uniques
    distinct_visitors.where(["visits.created_at > ?", 10.minutes.ago])
  end


end
