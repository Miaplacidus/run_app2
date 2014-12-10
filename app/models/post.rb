class Post < ActiveRecord::Base
  has_many :commitments
  has_one :challenge
  # differentiating between the organizer/creator of the run and joiners
  belongs_to :creator, class_name:"User", foreign_key:"creator_id"
  has_many :post_users
  has_many :users, :through => :post_users
  belongs_to :circle

  set_rgeo_factory_for_column(:location,
    RGeo::Geographic.spherical_factory(:srid => 4326))

  scope :upcoming_user_runs, lambda { |user_id|
    where(Commitment.where(user_id: user_id).pluck(:post_id)).where('time < ?', 1.hour.ago)
  }

  scope :upcoming_admin_runs, lambda { |user_id|
    where(creator_id: user_id).where('time < ?', 1.hour.ago)
  }

# filters = {user_lat, user_long, radius, gender_pref, user_id}
  scope :filter_by_gender_and_location, lambda { |filters|
    nearby_runs = where("ST_Distance(location, 'POINT(? ?)') < ?", filters[:user_long], filters[:user_lat], filters[:radius])

    if filters[:gender_pref] == 3
      nearby_runs.where("gender_pref == 0 OR gender_pref == ?", User.find(filters[:user_id]).gender)
    else
      nearby_runs.where("gender_pref == ?", User.find(filters[:user_id]).gender)
    end
  }

  scope :filter_by_age, lambda { |user_age_pref, filters| filter_by_gender_and_location(filters).where(age_pref: user_age_pref) }
  scope :filter_by_pace, lambda { |user_pace, filters| filter_by_gender_and_location(filters).where(pace: user_pace) }
  scope :filter_by_time, lambda { |start_time, end_time, filters| filter_by_gender_and_location(filters).where("time > ? AND time < ?", start_time, end_time) }
end

=begin
PACE LEVELS
0 - All/Any levels
1 - Military: 6 min and under/mile
2 - Advanced: 6-7 min/mi
3 - High Intermediate: 7-8 min/mi
4 - Intermediate: 8-9 min/mi
5 - Beginner: 9-10 min/mi
6 - Jogger: 10-11 min/mi
7 - Speedwalker: 11-12 min/mi
8 - Sprints: 12+ min/mi

GENDER PREFERENCES
0 - BOTH
1 - FEMALE
2 - MALE
# Below only used for post sorting purposes
3 - BOTH USER GENDER AND GENDER NEUTRAL POSTS

AGE PREFERENCES
0 - No preference
1 - 18-22
2 - 23-29
3 - 30-39
4 - 40-49
5 - 50-59
6 - 60-69
7 - 70-79
8 - 80+
=end
