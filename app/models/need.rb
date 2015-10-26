class Need < ActiveRecord::Base
  has_many :donations
  has_many :donors, :through => :donations
  belongs_to :organization
  belongs_to :user

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => ":placeholder"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :amount_requested, numericality: { greater_than: 0 }

  def percent_complete
    (self.amount_donated / self.amount_requested.to_f) * 100
  end

end
