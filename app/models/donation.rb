class Donation < ActiveRecord::Base
  belongs_to :need
  belongs_to :donor
  validates :amount, numericality: { greater_than: 0 }

  after_create :update_need_total

  def update_need_total
    self.need.amount_donated += self.amount
    self.need.save
  end

  def amount=(value)
    value.to_s.gsub!('$', '')
    super(value)
  end
end
