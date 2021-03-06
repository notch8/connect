class Need < ActiveRecord::Base
  has_many :donations
  has_many :donors, :through => :donations
  belongs_to :organization
  belongs_to :user

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :amount_requested, numericality: { greater_than: 0 }
  validates :posted_at, presence: true

  after_initialize :setup_posted_at

  def setup_posted_at
    self.posted_at = Time.now unless self.posted_at
  end

  def percent_complete
    (self.amount_donated / self.amount_requested.to_f) * 100
  end
end
