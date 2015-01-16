class Post < ActiveRecord::Base
  # Change class name to scheduled_runs or event

  before_validation :format_address
  before_validation :non_circle_posts_public
  after_create :create_organizer_commitment

  enum pace: ['All/Any Levels', 'Military: 6 min and under/mile', 'Advanced: 6-7 min/mi', 'High Intermediate: 7-8 min/mi', 'Intermediate: 8-9 min/mi', 'Beginner: 9-10 min/mi', 'Jogger: 10-11 min/mi', 'Speedwalker: 11-12 min/mi', 'Sprints: 12+ min/mi']
  enum age_pref: ['No preference', '18-23', '24-29', '30-39', '40-49', '50-59', '60-69', '70-79', '80+']
  enum gender_pref: ['Both Women and Men', 'Women Only', 'Men Only']

  has_many :commitments
  has_many :runners, through: :commitments, source: :user
  has_one :challenge
  belongs_to :organizer, class_name: "User", foreign_key:"organizer_id"
  belongs_to :circle

  validates_presence_of :organizer_id, :time, :pace, :age_pref, :gender_pref, :min_distance, :address, :location
  validates_inclusion_of :complete, :in => [true, false]
  validates_inclusion_of :max_runners, :in => [4, 7, 11, 14]
  validates_inclusion_of :min_amt, :in => [0, 5, 10, 15, 20]
  validates_inclusion_of :min_distance, :in => [1, 2, 3, 5, 9, 13, 17, 22, 26]

  set_rgeo_factory_for_column(:location, RGeo::Geographic.spherical_factory(:srid => 4326))

  scope :upcoming_user_runs, -> (user_id) { where(Commitment.where(user_id: user_id).pluck(:post_id)).where('time < ?', 1.hour.ago) }
  scope :upcoming_admin_runs, -> (user_id) { where(organizer_id: user_id).where('time < ?', 1.hour.ago) }
# filters = {user_lat, user_lon, radius, gender_pref, user_id}
  scope :filter_by_gender, -> (filters) {
    if filters[:gender_pref].to_i == 3
      where( "gender_pref = ? OR gender_pref = ?", 0, User.genders[ User.find(filters[:user_id]).gender.to_sym ])
    elsif filters[:gender_pref].to_i == 0
      where( "gender_pref = ?", 0 )
    else
      where( "gender_pref = ?", User.genders[ User.find(filters[:user_id]).gender.to_sym])
    end
  }
# TODO: make filter params more explicit
# TODO: add ordering by distance from user
  miles_to_meters = 1609.34
  scope :filter_by_location, -> (filters) { where("ST_Distance(location, 'POINT(? ?)') < ?", filters[:user_lon].to_f, filters[:user_lat].to_f, filters[:radius].to_f*miles_to_meters) }
  scope :filter_by_age, -> (filters) { filter_by_location(filters).filter_by_gender(filters).where(age_pref: filters[:age_pref].to_i) }
  scope :filter_by_pace, -> (filters) { filter_by_location(filters).filter_by_gender(filters).where(pace: filters[:pace].to_i) }
  scope :filter_by_time, -> (filters) { filter_by_location(filters).filter_by_gender(filters).where("time >= ? AND time <= ?", filters[:start_time], filters[:end_time]) }
  scope :filter_by_commitment, -> (filters) { filter_by_location(filters).filter_by_gender(filters).where("min_amt <= ?", filters[:min_amt]) }

  def time_in_tz
    Time.zone.parse(time.to_s).strftime("%a %B %e, %Y at %l:%M%P, %:z") + Time.zone.to_s
  end

  private
  def create_organizer_commitment
    if !self.circle_id || ( self.organizer_id != Circle.find(self.circle_id).admin_id )
      Commitment.create( post_id: self.id, user_id: self.organizer_id, amount: self.min_amt )
    end
  end

  def format_address
    self.address = Geocoder.address( [self.location.latitude, self.location.longitude] )
  end

  def non_circle_posts_public
    if !self.circle_id
      self.is_public = true
    end
  end
end
