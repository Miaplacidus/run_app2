require 'rails_helper'

RSpec.describe Commitment, :type => :model do

  it "has a valid factory" do
    expect(create(:commitment)).to be_valid
  end

  it "is invalid if the max number of runners has been reached" do
    # binding.pry
    post = create(:post, max_runners: 2)
    create(:commitment, post_id: post.id)
    expect( build(:commitment, post_id: post.id) ).to_not be_valid
  end
end
