class SentMessage < ActiveRecord::Base
  belongs_to :donor
  belongs_to :message

  validates :donor, presence: true
end
