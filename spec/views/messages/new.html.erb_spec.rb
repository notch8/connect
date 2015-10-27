require 'rails_helper'

RSpec.describe "messages/new", type: :view do
  before(:each) do
    assign(:message, Message.new(
      :need_id => 1,
      :body => "MyString",
      :donor_id => 1
    ))
  end

  it "renders new message form" do
    render

    assert_select "form[action=?][method=?]", messages_path, "post" do

      assert_select "input#message_need_id[name=?]", "message[need_id]"

      assert_select "input#message_body[name=?]", "message[body]"

      assert_select "input#message_donor_id[name=?]", "message[donor_id]"
    end
  end
end
