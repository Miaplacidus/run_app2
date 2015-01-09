require 'rails_helper'

RSpec.describe Commitment, :type => :model do

  it "has a valid factory" do
    binding.pry
    expect(create(:commitment)).to be_valid
  end

  xit "is invalid if the max number of runners has been reached" do
    # binding.pry
    post = create(:post, max_runners: 2)
    # create_list(:commitment, 1, post_id: post.id)
    expect( build(:commitment, post_id: post.id) ).to_not be_valid
  end
end
