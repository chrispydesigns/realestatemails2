require 'rails_helper'

RSpec.describe "plans/index", :type => :view do
  before(:each) do
    assign(:plans, [
      Plan.create!(
        :name => "Name",
        :price => "",
        :price => "",
        :frequency => 1
      ),
      Plan.create!(
        :name => "Name",
        :price => "",
        :price => "",
        :frequency => 1
      )
    ])
  end

  it "renders a list of plans" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
