class Donors::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/donor.rb)
    @donor = Donor.from_omniauth(request.env["omniauth.auth"])

    if @donor.persisted?
      sign_in_and_redirect @donor, :event => :authentication #this will throw if @donor is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_donor_registration_url
    end
  end
end
