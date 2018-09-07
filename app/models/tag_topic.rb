class TagTopic < ApplicationRecord
  validates :topic, presence: true, uniqueness: true

  has_many :taggings
  has_many :shortened_urls, through: :taggings

  def popular_links
    shortened_urls.joins(:visits)
      .group(:short_url, :long_url)
      .count('visits.id')
      .sort_by { |k,v| -v }
      .map { |el| { short_url: el[0][0], long_url: el[0][1], visits: el[1] }}
  end
end
