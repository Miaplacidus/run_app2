require 'rails_helper'

RSpec.describe "Commitments", :type => :request do
  describe "GET /commitments" do
    it "works! (now write some real specs)" do
      get commitments_path
      expect(response).to have_http_status(200)
    end
  end
end
