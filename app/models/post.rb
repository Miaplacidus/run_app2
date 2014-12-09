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

  scope :belongs_to_user, lambda { |user_id| user_posts = Post.where(Commitments.where(user_id: user_id).pluck(:post_id))
    one_hour = 3600
    user_posts.select { |post| post.time < Time.now - one_hour }
  }

  scope :get_admin_posts, lambda { |user_id| admin_posts = Post.where(Commitments.where(user_id: user_id).pluck(:post_id))
    one_hour = 3600
    user_posts.select { |post| post.time < Time.now - one_hour }
  }

# filters = {user_lat, user_long, radius, gender_pref, user_gender}
  scope :filter_by_gender_and_location, lambda { |filters|
    posts = Post.all.select do |post|
      Haversine.distance(filters[:user_lat], filters[:user_long], post.latitude, post.longitude).to_mi <= filters[:radius]
    end

    if filters[:gender_pref] == 3
      posts.select do |post|
        post.gender_pref == 0 || post.gender_pref == filters[:user_gender]
      end
    else
      posts.select do |post|
        post.gender_pref == filters[:gender_pref]
      end
    end
  }
  scope :filter_by_age, lambda { |user_age_pref, filters| filter_by_gender_and_location(filters).select { |post| post.age_pref == user_age_pref }}
  scope :filter_by_pace, lambda { |user_pace, filters| filter_by_gender_and_location(filters).select { |post| post.pace == user_pace }}
  scope :filter_by_time, lambda { |start_time, end_time, filters| filter_by_gender_and_location(filters).select { |post| post.time > start_time && post.time < end_time }}
end
