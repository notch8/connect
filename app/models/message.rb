class Message < ActiveRecord::Base
  belongs_to :need
  belongs_to :donor
  has_many :sent_messages
  has_many :donors, :through => :sent_messages

  accepts_nested_attributes_for :sent_messages, reject_if: proc { |attributes| attributes['donor_id'].to_s.to_i <= 0 }

  after_save :send_email

  def sent_to
    self.sent_messages.where('sent_at IS NOT NULL').collect {|sent| sent.donor.name}
  end

  def send_email
    self.sent_messages.where('sent_at IS NULL').each do |sent_message|
      next unless sent_message.donor.present?
      begin
        AdminMailer.message_email(self, sent_message.donor).deliver
        sent_message.update_attribute(:sent_at, Time.now)
      rescue
      end
    end
    return true
  end
end
