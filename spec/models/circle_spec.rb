require 'rails_helper'

RSpec.describe Circle, :type => :model do
  it "is invalid if name is not unique" do
    create(:circle, name: "Asimov Aces")
    expect(build(:circle, name: "Asimov Aces")).to_not be_valid
  end

  it "is invalid without a city" do

  end

  it "is invalid without a location" do
    expect(build(:circle, location: nil))
  end

end
