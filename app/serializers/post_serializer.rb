class PostSerializer < ActiveModel::Serializer
  attributes :id, :time, :pace, :notes, :complete, :min_amt, :age_pref, :gender_pref, :max_runners, :min_distance, :address, :created_at, :updated_at, :location, :pace_title, :age_preference_range, :time_in_tz

  has_many :commitments
  has_one :challenge
  has_one :organizer, class_name:"User", foreign_key:"organizer_id"
  has_many :post_users
  has_many :users, :through => :post_users
  has_one :circle
end
