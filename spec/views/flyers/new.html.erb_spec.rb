require 'rails_helper'

RSpec.describe "flyers/new", :type => :view do
  before(:each) do
    assign(:flyer, Flyer.new(
      :name => "MyString",
      :description => "MyText",
      :content => "MyText"
    ))
  end

  it "renders new flyer form" do
    render

    assert_select "form[action=?][method=?]", flyers_path, "post" do

      assert_select "input#flyer_name[name=?]", "flyer[name]"

      assert_select "textarea#flyer_description[name=?]", "flyer[description]"

      assert_select "textarea#flyer_content[name=?]", "flyer[content]"
    end
  end
end
