require 'rails_helper'

RSpec.describe "flyers/show", :type => :view do
  before(:each) do
    @flyer = assign(:flyer, Flyer.create!(
      :name => "Name",
      :description => "MyText",
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
