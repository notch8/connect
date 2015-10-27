class User < ActiveRecord::Base
  belongs_to :organization
  has_many :donations
  has_many :sent_messages
  has_many :needs
  
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization
  attr_accessor :access_code

  validate :access_code_acceptance, on: :create

  def access_code_acceptance
    if access_code.blank?
      errors.add :access_code, 'must match an existing organization'
    else
      organization = Organization.where(access_code: self.access_code).first
      if organization.blank?
        errors.add :access_code, 'must match an existing organization'
      end
      self.organization = organization
    end
  end
end
