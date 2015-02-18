require 'rails_helper'

RSpec.describe "templates/edit", :type => :view do
  before(:each) do
    @template = assign(:template, Template.create!(
      :name => "MyString",
      :description => "MyText",
      :content => "MyText"
    ))
  end

  it "renders the edit template form" do
    render

    assert_select "form[action=?][method=?]", template_path(@template), "post" do

      assert_select "input#template_name[name=?]", "template[name]"

      assert_select "textarea#template_description[name=?]", "template[description]"

      assert_select "textarea#template_content[name=?]", "template[content]"
    end
  end
end
