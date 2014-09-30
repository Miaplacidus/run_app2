require "rails_helper"

RSpec.describe JoinRequestsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/join_requests").to route_to("join_requests#index")
    end

    it "routes to #new" do
      expect(:get => "/join_requests/new").to route_to("join_requests#new")
    end

    it "routes to #show" do
      expect(:get => "/join_requests/1").to route_to("join_requests#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/join_requests/1/edit").to route_to("join_requests#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/join_requests").to route_to("join_requests#create")
    end

    it "routes to #update" do
      expect(:put => "/join_requests/1").to route_to("join_requests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/join_requests/1").to route_to("join_requests#destroy", :id => "1")
    end

  end
end
