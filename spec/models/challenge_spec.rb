require 'rails_helper'

RSpec.describe Challenge, :type => :model do

  it "has a valid factory" do
    expect(build(:challenge)).to be_valid
  end

  it "is invalid without a name" do
    expect( build(:challenge, name: nil) ).to_not be_valid
  end

  it "is invalid without a sender" do
    expect( build(:challenge, sender_id: nil) ).to_not be_valid
  end

  it "is invalid without a recipient" do
    expect( build(:challenge, recipient_id:nil) ).to_not be_valid
  end

  it "gets recently sent challenges" do
    sending_circle_id = create(:challenge).sender_id
    expect(Challenge.recently_sent_challenges(sending_circle_id).count).to eq 1
  end

  it "gets recently received challenges" do
    receiving_circle_id = create(:challenge).recipient_id
    expect(Challenge.recently_received_challenges(receiving_circle_id).count).to eq 1
  end
end
