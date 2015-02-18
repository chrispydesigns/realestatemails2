require 'rails_helper'

RSpec.describe "templates/new", :type => :view do
  before(:each) do
    assign(:template, Template.new(
      :name => "MyString",
      :description => "MyText",
      :content => "MyText"
    ))
  end

  it "renders new template form" do
    render

    assert_select "form[action=?][method=?]", templates_path, "post" do

      assert_select "input#template_name[name=?]", "template[name]"

      assert_select "textarea#template_description[name=?]", "template[description]"

      assert_select "textarea#template_content[name=?]", "template[content]"
    end
  end
end
