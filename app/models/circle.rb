class Circle < ActiveRecord::Base
  # Administrator has the ability to delete the circle and to delete a post. Administrator can also create posts
  # without being committed to them. Other members of the circle can schedule runs for the group, but they must commit
  # to those runs.
  # A post can be both associated with a circle and marked public so other users can join the circle if they would like to
  # join the run

  before_validation do |_record|
    get_circle_coords
  end

  after_create :add_admin_to_circle

  enum level: ['All/Any Levels', 'Military: 6 min and under/mile', 'Advanced: 6-7 min/mi', 'High Intermediate: 7-8 min/mi', 'Intermediate: 8-9 min/mi', 'Beginner: 9-10 min/mi', 'Jogger: 10-11 min/mi', 'Speedwalker: 11-12 min/mi', 'Sprints: 12+ min/mi']

  belongs_to :admin, class_name: 'User'
  has_many :circle_users
  has_many :members, through: :circle_users, source: :user
  has_many :posts
  has_many :join_requests
  has_many :sent_challenges, class_name: 'Challenge', foreign_key: 'sender_id'
  has_many :received_challenges, class_name: 'Challenge', foreign_key: 'recipient_id'

  validates_uniqueness_of :name
  validates_presence_of :city, :location

  scope :get_user_circles, -> (user_id) { where(id: CircleUser.where(user_id: user_id).map(&:circle_id)) }
  scope :get_admin_circles, -> (user_id) { where(admin_id: user_id) }
  miles_to_meters = 1609.34
  scope :filter_by_location, -> (filters) { where("ST_Distance(location, 'POINT(? ?)') < ?", filters[:user_lon].to_f, filters[:user_lat].to_f, filters[:radius].to_f * miles_to_meters) }
  scope :filter_by_full, -> (filters) { select { |circle| CircleUser.where(circle_id: circle.id).count < circle.max_members }.filter_by_location(filters) }

  private

  def get_circle_coords
    coordinates = Geocoder.coordinates(city)
    return false unless coordinates
    self.location = "POINT(#{coordinates[1]} #{coordinates[0]})"
  end

  def add_admin_to_circle
    CircleUser.create(user_id: admin_id, circle_id: id)
  end
end
