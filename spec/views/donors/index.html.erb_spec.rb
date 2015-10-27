require 'rails_helper'

RSpec.describe "donors/index", type: :view do
  before(:each) do
    assign(:donors, [
      Donor.create!(
        :name => "Name",
        :image => "",
        :email => "Email",
        :password => "Password",
        :password_confirmation => "Password Confirmation"
      ),
      Donor.create!(
        :name => "Name",
        :image => "",
        :email => "Email",
        :password => "Password",
        :password_confirmation => "Password Confirmation"
      )
    ])
  end

  it "renders a list of donors" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Password".to_s, :count => 2
    assert_select "tr>td", :text => "Password Confirmation".to_s, :count => 2
  end
end
