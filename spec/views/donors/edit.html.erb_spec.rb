require 'rails_helper'

RSpec.describe "donors/edit", type: :view do
  before(:each) do
    @donor = assign(:donor, Donor.create!(
      :name => "MyString",
      :image => "",
      :email => "MyString",
      :password => "MyString",
      :password_confirmation => "MyString"
    ))
  end

  it "renders the edit donor form" do
    render

    assert_select "form[action=?][method=?]", donor_path(@donor), "post" do

      assert_select "input#donor_name[name=?]", "donor[name]"

      assert_select "input#donor_image[name=?]", "donor[image]"

      assert_select "input#donor_email[name=?]", "donor[email]"

      assert_select "input#donor_password[name=?]", "donor[password]"

      assert_select "input#donor_password_confirmation[name=?]", "donor[password_confirmation]"
    end
  end
end
