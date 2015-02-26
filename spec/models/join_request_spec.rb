require 'rails_helper'

RSpec.describe JoinRequest, type: :model do
  vcr_options = { cassette_name: 'join_req_gmaps', record: :new_episodes }

  it 'has a valid factory', vcr: vcr_options do
    expect(create(:join_request)).to be_valid
  end

  describe 'validations', vcr: vcr_options do
    it 'is invalid without a circle' do
      expect(build(:join_request, circle_id: nil)).to_not be_valid
    end

    it 'is invalid without a user' do
      expect(build(:join_request, user_id: nil)).to_not be_valid
    end
  end
end
