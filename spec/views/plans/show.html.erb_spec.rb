require 'rails_helper'

RSpec.describe "plans/show", :type => :view do
  before(:each) do
    @plan = assign(:plan, Plan.create!(
      :name => "Name",
      :price => "",
      :price => "",
      :frequency => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
  end
end
