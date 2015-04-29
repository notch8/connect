require 'rails_helper'

RSpec.describe "organizations/new", type: :view do
  before(:each) do
    assign(:organization, Organization.new(
      :title => "MyString",
      :tagline => "MyString"
    ))
  end

  it "renders new organization form" do
    render

    assert_select "form[action=?][method=?]", organizations_path, "post" do

      assert_select "input#organization_title[name=?]", "organization[title]"

      assert_select "input#organization_tagline[name=?]", "organization[tagline]"
    end
  end
end
