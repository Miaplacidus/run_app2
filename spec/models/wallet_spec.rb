require 'rails_helper'

RSpec.describe Wallet, :type => :model do

  it "is invalid if balance drops below zero" do
    expect(build(:wallet, balance: -1.0)).to_not be_valid
  end
end
