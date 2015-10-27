require 'rails_helper'

RSpec.describe "donations/edit", type: :view do
  before(:each) do
    @donation = assign(:donation, Donation.create!(
      :amount => "9.99",
      :need_id => 1,
      :donor_id => 1
    ))
  end

  it "renders the edit donation form" do
    render

    assert_select "form[action=?][method=?]", donation_path(@donation), "post" do

      assert_select "input#donation_amount[name=?]", "donation[amount]"

      assert_select "input#donation_need_id[name=?]", "donation[need_id]"

      assert_select "input#donation_donor_id[name=?]", "donation[donor_id]"
    end
  end
end
