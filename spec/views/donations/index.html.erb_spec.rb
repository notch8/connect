require 'rails_helper'

RSpec.describe "donations/index", type: :view do
  before(:each) do
    assign(:donations, [
      Donation.create!(
        :amount => "9.99",
        :need_id => 1,
        :donor_id => 2
      ),
      Donation.create!(
        :amount => "9.99",
        :need_id => 1,
        :donor_id => 2
      )
    ])
  end

  it "renders a list of donations" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
