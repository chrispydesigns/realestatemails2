require 'rails_helper'

RSpec.describe "plans/edit", :type => :view do
  before(:each) do
    @plan = assign(:plan, Plan.create!(
      :name => "MyString",
      :price => "",
      :price => "",
      :frequency => 1
    ))
  end

  it "renders the edit plan form" do
    render

    assert_select "form[action=?][method=?]", plan_path(@plan), "post" do

      assert_select "input#plan_name[name=?]", "plan[name]"

      assert_select "input#plan_price[name=?]", "plan[price]"

      assert_select "input#plan_price[name=?]", "plan[price]"

      assert_select "input#plan_frequency[name=?]", "plan[frequency]"
    end
  end
end
