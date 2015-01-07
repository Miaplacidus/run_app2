require 'rails_helper'

RSpec.describe Post, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  let!(:post) { create(:post) }

  it "has a valid factory" do
    expect(post.class.name).to eq("Post")
  end

  it "is invalid without required attributes" do

  end

  it "returns the correct pace"

  context "when post is public" do
    it "creates associated commitment for organizer" do

    end
  end

  context "when post is associated with a circle" do
    it "" do

    end
  end
end
