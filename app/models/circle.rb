class Circle < ActiveRecord::Base
  # Differentiate between reg users and administrator
  belongs_to :admin, class_name:"User"

  has_many :circle_users
  has_many :users, :through => :circle_users

  has_many :posts

  has_many :join_requests

  has_many :sent_challenges, class_name: "Challenge", foreign_key:"sender_id"
  has_many :received_challenges, class_name: "Challenge", foreign_key:"recipient_id"
end
