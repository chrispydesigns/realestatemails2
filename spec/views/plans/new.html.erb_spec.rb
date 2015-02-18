require 'rails_helper'

RSpec.describe "plans/new", :type => :view do
  before(:each) do
    assign(:plan, Plan.new(
      :name => "MyString",
      :price => "",
      :price => "",
      :frequency => 1
    ))
  end

  it "renders new plan form" do
    render

    assert_select "form[action=?][method=?]", plans_path, "post" do

      assert_select "input#plan_name[name=?]", "plan[name]"

      assert_select "input#plan_price[name=?]", "plan[price]"

      assert_select "input#plan_price[name=?]", "plan[price]"

      assert_select "input#plan_frequency[name=?]", "plan[frequency]"
    end
  end
end
