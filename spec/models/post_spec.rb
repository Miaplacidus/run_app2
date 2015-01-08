require 'rails_helper'

RSpec.describe Post, :type => :model do

  it "has a valid factory" do
    expect(create(:post)).to be_valid
  end

  it "is invalid without an organizer" do
    expect(build(:post, organizer_id: nil)).to_not be_valid
  end

  it "is invalid without a time" do
    expect(build(:post, time: nil)).to_not be_valid
  end

  it "is invalid without a pace" do
    expect(build(:post, pace: nil)).to_not be_valid
  end

  it "is invalid without an age preference" do
    expect(build(:post, age_pref: nil)).to_not be_valid
  end

  it "is invalid without a gender preference" do
    expect(build(:post, gender_pref: nil)).to_not be_valid
  end

  it "is invalid without a minimum distance" do
    expect(build(:post, min_distance: nil)).to_not be_valid
  end

  it "is invalid without an address" do
    expect(build(:post, address: nil)).to_not be_valid
  end

  it "is invalid without a location" do
    expect(build(:post, location: nil)).to_not be_valid
  end

  it "is invalid without a complete flag" do
    expect(build(:post, complete: nil)).to_not be_valid
  end

  it "is invalid without a maximum number of runners" do
    expect(build(:post, max_runners: nil)).to_not be_valid
  end

  it "is invalid without a minimum commitment" do
    expect(build(:post, min_amt: nil)).to_not be_valid
  end

  it "is invalid without a minimum distance" do
    expect(build(:post, min_distance: nil)).to_not be_valid
  end

  xit "returns the time in the correct time zone" do
  end

  context "when post is public" do
    # let!(:post) { create(:post) }
    it "creates associated commitment for organizer" do
      post = create(:post, circle_id: nil)
      expect(Commitment.exists?(post_id: post.id)).to be true
    end
  end

  context "when post is associated with a circle" do
    it "does create associated commitment for circle members" do

    end

    it "does not create associated commitment for circle admin" do
      post = build(:post)
      post.organizer_id = Circle.find(post.circle_id).admin_id
      post.save
      expect(Commitment.exists?(post_id: post.id)).to be false
    end
  end
end
