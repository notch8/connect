require 'rails_helper'

RSpec.describe "needs/new", type: :view do
  before(:each) do
    assign(:need, Need.new(
      :title => "MyString",
      :description => "MyText",
      :amount_requested => "9.99",
      :amount_donated => "9.99"
    ))
  end

  it "renders new need form" do
    render

    assert_select "form[action=?][method=?]", needs_path, "post" do

      assert_select "input#need_title[name=?]", "need[title]"

      assert_select "textarea#need_description[name=?]", "need[description]"

      assert_select "input#need_amount_requested[name=?]", "need[amount_requested]"

      assert_select "input#need_amount_donated[name=?]", "need[amount_donated]"
    end
  end
end
