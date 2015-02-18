require 'rails_helper'

RSpec.describe "flyers/index", :type => :view do
  before(:each) do
    assign(:flyers, [
      Flyer.create!(
        :name => "Name",
        :description => "MyText",
        :content => "MyText"
      ),
      Flyer.create!(
        :name => "Name",
        :description => "MyText",
        :content => "MyText"
      )
    ])
  end

  it "renders a list of flyers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
