class Post < ActiveRecord::Base
  # consider using arrays/ enums
  # Change class name to scheduled_runs or event
  PACE_LEVELS = {
    0 => "All/Any levels",
    1 => "Military: 6 min and under/mile",
    2 => "Advanced: 6-7 min/mi",
    3 => "High Intermediate: 7-8 min/mi",
    4 => "Intermediate: 8-9 min/mi",
    5 => "Beginner: 9-10 min/mi",
    6 => "Jogger: 10-11 min/mi",
    7 => "Speedwalker: 11-12 min/mi",
    8 => "Sprints: 12+ min/mi"
  }

  AGE_PREFERENCES = {
    0 => "No preference",
    1 => "18-22",
    2 => "23-29",
    3 => "30-39",
    4 => "40-49",
    5 => "50-59",
    6 => "60-69",
    7 => "70-79",
    8 => "80+"
  }

  GENDER_PREFERENCES = {
    0 => "Both",
    1 => "Women Only",
    2 => "Men Only"
  }

  has_many :commitments
  has_one :challenge
  belongs_to :organizer, class_name:"User", foreign_key:"organizer_id"
  # has_many :post_users
  # has_many :users, :through => :post_users
  belongs_to :circle

  set_rgeo_factory_for_column(:location, RGeo::Geographic.spherical_factory(:srid => 4326))
  scope :upcoming_user_runs, -> (user_id) { where(Commitment.where(user_id: user_id).pluck(:post_id)).where('time < ?', 1.hour.ago) }
  scope :upcoming_admin_runs, -> (user_id) { where(creator_id: user_id).where('time < ?', 1.hour.ago) }

# filters = {user_lat, user_lon, radius, gender_pref, user_id}
  scope :filter_by_gender, -> (filters) {
    if filters[:gender_pref].to_i == 3
      where("gender_pref = ? OR gender_pref = ?", 0, User.genders[ User.find(filters[:user_id]).gender.to_sym ])
    elsif filters[:gender_pref].to_i == 0
      where("gender_pref = ?", 0)
    else
      where("gender_pref = ?", User.genders[ User.find(filters[:user_id]).gender.to_sym ])
    end
  }

  scope :filter_by_location, -> (filters) { where("ST_Distance(location, 'POINT(? ?)') < ?", filters[:user_lon].to_f, filters[:user_lat].to_f, filters[:radius].to_f*1609.34) }
  scope :filter_by_age, -> (filters) { filter_by_location(filters).filter_by_gender(filters).where(age_pref: filters[:age_pref].to_i) }
  scope :filter_by_pace, -> (filters) { filter_by_location(filters).filter_by_gender(filters).where(pace: filters[:pace].to_i) }
  scope :filter_by_time, -> (filters) { filter_by_location(filters).filter_by_gender(filters).where("time >= ? AND time <= ?", filters[:start_time], filters[:end_time]) }

  scope :get_runners, -> (id) { where( Commitment.where(post_id: id) )}
  def pace_title
    PACE_LEVELS[pace]
  end

  def age_preference_range
    AGE_PREFERENCES[age_pref]
  end

  def gender_preference
    GENDER_PREFERENCES[gender_pref]
  end

  def time_in_tz
    Time.zone.parse(time.to_s).strftime("%a %B %e, %Y at %l:%M%P, %:z") + Time.zone.to_s
  end

  def runners
    User.where(id: Commitment.where(post_id: id).pluck(:user_id))
  end
end

=begin
GENDER PREFERENCES
0 - BOTH
1 - FEMALE
2 - MALE
# Below only used for post sorting purposes
3 - BOTH USER GENDER AND GENDER NEUTRAL POSTS
=end
