require "rails_helper"

RSpec.describe FlyersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/flyers").to route_to("flyers#index")
    end

    it "routes to #new" do
      expect(:get => "/flyers/new").to route_to("flyers#new")
    end

    it "routes to #show" do
      expect(:get => "/flyers/1").to route_to("flyers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/flyers/1/edit").to route_to("flyers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/flyers").to route_to("flyers#create")
    end

    it "routes to #update" do
      expect(:put => "/flyers/1").to route_to("flyers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/flyers/1").to route_to("flyers#destroy", :id => "1")
    end

  end
end
