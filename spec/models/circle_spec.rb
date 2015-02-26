require 'rails_helper'

RSpec.describe Circle, type: :model do
  vcr_options = { cassette_name: 'circle_gmaps', record: :new_episodes }

  it 'has a valid factory', vcr: vcr_options do
    expect(build(:circle)).to be_valid
  end

  it 'has an admin who is also a member', vcr: vcr_options do
    circle = create(:circle)
    expect(CircleUser.where('circle_id = ? AND user_id = ?', circle.id, circle.admin_id).count).to eq 1
  end

  describe 'validations', vcr: vcr_options do
    it 'is invalid if name is not unique' do
      create(:circle, name: 'Asimov Aces')
      expect(build(:circle, name: 'Asimov Aces')).to_not be_valid
    end

    it 'is invalid without a city' do
      expect(build(:circle, city: nil)).to_not be_valid
    end

    it 'is invalid without a location' do
      expect(build(:circle, city: 'Utopia, NoLand')).to_not be_valid
    end
  end

  describe 'scopes', vcr: vcr_options do
    it 'returns a list of circles to which a user belongs' do
      user = create(:user)
      create_list(:circle_user, 3, user: user)
      expect(Circle.get_user_circles(user.id).count).to eq 3
    end
  end
end
