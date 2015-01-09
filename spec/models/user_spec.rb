require 'rails_helper'

RSpec.describe User, :type => :model do

  xit "is invalid without an email" do
    expect(build(:user, email: nil)).to_not be_valid
  end

  xit "is invalid without a first name" do
    expect(build(:user, first_name: nil)).to_not be_valid
  end

  it "is invalid if emails are not unique" do
    create(:user, email: "iamrobot@gmail.com")
    expect(build(:user, email: "iamrobot@gmail.com")).to_not be_valid
  end

  it "returns the user's gender" do
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      :provider => 'facebook',
      :uid => '1234567',
      :info => {
        :first_name => "Sophie",
        :image => 'http://graph.facebook.com/1234567/picture?type=square'
      },
      :credentials => {
        :token => 'ABCDEF',
        :expires_at => 12262551311
      },
      :extra => {
        :raw_info => {
          :gender => 'female',
          :email => "sophie@internet.com",
          :birthday => "03/14/1987"
        }
      }
    })

    user = User.from_omniauth(OmniAuth.config.mock_auth[:facebook])
    expect(user.gender).to eq("female")
  end

  it "returns the integer corresponding to the user's gender" do
    expect(create(:user, gender: 1).db_gender).to eq 1
  end

  it "returns the age range for a user" do
    expect(create(:user, bday: '03/14/1987').age_category).to eq 2
  end

  xit "returns the user's level" do

  end

  xit "returns the user's rating" do

  end
end
