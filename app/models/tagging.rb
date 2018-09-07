class Tagging < ApplicationRecord
  validates :tag_topic_id, presence: true
  validates :shortened_url_id, presence: true

  belongs_to :tag_topic
  belongs_to :shortened_url
end
