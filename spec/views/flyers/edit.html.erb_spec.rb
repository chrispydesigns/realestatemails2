require 'rails_helper'

RSpec.describe "flyers/edit", :type => :view do
  before(:each) do
    @flyer = assign(:flyer, Flyer.create!(
      :name => "MyString",
      :description => "MyText",
      :content => "MyText"
    ))
  end

  it "renders the edit flyer form" do
    render

    assert_select "form[action=?][method=?]", flyer_path(@flyer), "post" do

      assert_select "input#flyer_name[name=?]", "flyer[name]"

      assert_select "textarea#flyer_description[name=?]", "flyer[description]"

      assert_select "textarea#flyer_content[name=?]", "flyer[content]"
    end
  end
end
