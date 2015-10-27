class Donor < ActiveRecord::Base
  has_many :donations
  has_many :sent_messages
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:facebook]

  has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "missing/:style.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :name, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |donor|
      donor.email = auth.info.email
      donor.password = Devise.friendly_token[0,20]
      donor.name = auth.info.name   # assuming the donor model has a name
      donor.facebook_image_url = auth.info.image # assuming the donor model has an image
    end
  end

  def image_url(size=:thumb)
    if self.facebook_image_url
      if size == :medium
        return self.facebook_image_url + "?type=large"
      else
        return self.facebook_image_url
      end
    else
      return self.image.url(size)
    end
    # if fb image
    # else use image url (which will default to avatar)
  end

end
