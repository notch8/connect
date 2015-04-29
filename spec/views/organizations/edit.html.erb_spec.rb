require 'rails_helper'

RSpec.describe "organizations/edit", type: :view do
  before(:each) do
    @organization = assign(:organization, Organization.create!(
      :title => "MyString",
      :tagline => "MyString"
    ))
  end

  it "renders the edit organization form" do
    render

    assert_select "form[action=?][method=?]", organization_path(@organization), "post" do

      assert_select "input#organization_title[name=?]", "organization[title]"

      assert_select "input#organization_tagline[name=?]", "organization[tagline]"
    end
  end
end
