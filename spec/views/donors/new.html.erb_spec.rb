require 'rails_helper'

RSpec.describe "donors/new", type: :view do
  before(:each) do
    assign(:donor, Donor.new(
      :name => "MyString",
      :image => "",
      :email => "MyString",
      :password => "MyString",
      :password_confirmation => "MyString"
    ))
  end

  it "renders new donor form" do
    render

    assert_select "form[action=?][method=?]", donors_path, "post" do

      assert_select "input#donor_name[name=?]", "donor[name]"

      assert_select "input#donor_image[name=?]", "donor[image]"

      assert_select "input#donor_email[name=?]", "donor[email]"

      assert_select "input#donor_password[name=?]", "donor[password]"

      assert_select "input#donor_password_confirmation[name=?]", "donor[password_confirmation]"
    end
  end
end
