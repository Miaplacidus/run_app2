require "rails_helper"

RSpec.describe CommitmentsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/commitments").to route_to("commitments#index")
    end

    it "routes to #new" do
      expect(:get => "/commitments/new").to route_to("commitments#new")
    end

    it "routes to #show" do
      expect(:get => "/commitments/1").to route_to("commitments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/commitments/1/edit").to route_to("commitments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/commitments").to route_to("commitments#create")
    end

    it "routes to #update" do
      expect(:put => "/commitments/1").to route_to("commitments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/commitments/1").to route_to("commitments#destroy", :id => "1")
    end

  end
end
