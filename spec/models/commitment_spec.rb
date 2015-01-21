require 'rails_helper'

RSpec.describe Commitment, :type => :model do
  vcr_options = { cassette_name: "commitment_gmaps", record: :new_episodes }

  it "has a valid factory", vcr: vcr_options do
    expect(create(:commitment)).to be_valid
  end

  describe "validations", vcr: vcr_options do
    it "is invalid if the max number of runners has been reached" do
      post = create(:post, max_runners: 4)
      create_list(:commitment, 4, post: post)
      expect( build(:commitment, post_id: post.id) ).to_not be_valid
    end
  end
end
