require 'rails_helper'

RSpec.describe Challenge, :type => :model do

  it "is invalid without a name" do
    expect( build(:challenge, name: nil) ).to_not be_valid
  end

  it "is invalid without a sender" do
    expect( build(:challenge, sender_id: nil) ).to_not be_valid
  end

  it "is invalid without a recipient" do
    expect( build(:challenge, recipient_id:nil) ).to_not be_valid
  end
end
