require 'rails_helper'

RSpec.describe "Wallets", :type => :request do
  describe "GET /wallets" do
    xit "works! (now write some real specs)" do
      get wallets_path
      expect(response).to have_http_status(200)
    end
  end
end
