require 'rails_helper'

RSpec.describe CircleUser, type: :model do
  vcr_options = { cassette_name: 'circle_user_gmaps', record: :new_episodes }

  it 'has a valid factory', vcr: vcr_options do
    expect(create(:circle_user)).to be_valid
  end

  describe 'validations', vcr: vcr_options do
    it 'is invalid if the max number of members has been reached' do
      circle = create(:circle)
      create_list(:circle_user, 24, circle: circle)
      expect(build(:circle_user, circle: circle)).to_not be_valid
    end
  end
end
