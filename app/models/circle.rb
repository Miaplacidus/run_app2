class Circle < ActiveRecord::Base
  # Administrator has the ability to delete the circle and to delete a post. Administrator can also create posts
  # without being committed to them. Other members of the circle can schedule runs for the group, but they must commit
  # to those runs.
  belongs_to :admin, class_name:"User"
  has_many :circle_users
  has_many :users, :through => :circle_users
  has_many :posts
  has_many :join_requests
  has_many :sent_challenges, class_name: "Challenge", foreign_key:"sender_id"
  has_many :received_challenges, class_name: "Challenge", foreign_key:"recipient_id"

  validates_uniqueness_of :name

  scope :get_user_circles, lambda { |user_id| where(id: CircleUsers.where(user_id: user_id).map { |circle_user| circle_user.circle_id }) }
  scope :get_admin_circles, lambda { |user_id| where(admin_id: user_id) }
  scope :filter_by_location, lambda { |user_lat, user_long, radius|  where("")}
  # scope :sent_challenges, lambda { |id| where(id: id).first.sent_challenges.order(:created_at) }
  # scope :received_challenges, lambda { |id| where(id: id).first.received_challenges.order(:created_at) }


  def self.filter_by_location(user_lat, user_long, radius)
    Circle.all.select do |circle|
      Haversine.distance(user_lat, user_long, circle.latitude, circle.longitude).to_mi <= radius
    end
  end

  def self.filter_by_full(user_lat, user_long, radius)
    circles = self.filter_by_location(user_lat, user_long, radius)
    circles.select do |circle|
      CircleUsers.where(circle_id: circle.id).length < circle.max_members
    end
  end
end

