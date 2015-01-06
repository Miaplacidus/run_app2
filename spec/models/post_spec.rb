require 'rails_helper'

RSpec.describe Post, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  let!(:post) { create(:post) }

  it "has a valid factory" do
    binding.pry
    expect(post.class.name).to eq("Post")
  end
end
