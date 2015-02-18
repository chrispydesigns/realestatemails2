require 'rails_helper'

RSpec.describe "Flyers", :type => :request do
  describe "GET /flyers" do
    it "works! (now write some real specs)" do
      get flyers_path
      expect(response.status).to be(200)
    end
  end
end
