require 'rails_helper'

RSpec.describe "donations/new", type: :view do
  before(:each) do
    assign(:donation, Donation.new(
      :amount => "9.99",
      :need_id => 1,
      :donor_id => 1
    ))
  end

  it "renders new donation form" do
    render

    assert_select "form[action=?][method=?]", donations_path, "post" do

      assert_select "input#donation_amount[name=?]", "donation[amount]"

      assert_select "input#donation_need_id[name=?]", "donation[need_id]"

      assert_select "input#donation_donor_id[name=?]", "donation[donor_id]"
    end
  end
end
