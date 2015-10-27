require 'rails_helper'

RSpec.describe "donors/show", type: :view do
  before(:each) do
    @donor = assign(:donor, Donor.create!(
      :name => "Name",
      :image => "",
      :email => "Email",
      :password => "Password",
      :password_confirmation => "Password Confirmation"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Password/)
    expect(rendered).to match(/Password Confirmation/)
  end
end
