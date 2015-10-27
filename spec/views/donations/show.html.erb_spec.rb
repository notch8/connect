require 'rails_helper'

RSpec.describe "donations/show", type: :view do
  before(:each) do
    @donation = assign(:donation, Donation.create!(
      :amount => "9.99",
      :need_id => 1,
      :donor_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
